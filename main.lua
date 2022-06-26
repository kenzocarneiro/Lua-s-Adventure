-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

if arg[#arg] == "vsc_debug" then require("lldebugger").start() end
rawset = nil -- Disable rawset
rawget = nil -- Disable rawget

local mainFont = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 15)
love.graphics.setFont(mainFont)


--- Load the game
function love.load()
    math.randomseed(os.time())
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setDefaultFilter("nearest", "nearest")
    -- Pour notre magnifique HUD
    local Hud = require("hud/hud")
    G_eltCounter = 0

    local Player = require("entity/player")
    local Room = require("room")
    local Vector = require("vector")
    local Data = require("data")

    G_blackoutOnPlayer = false
    G_blackoutCurrentFrame = 250
    G_blackoutSFX = false
    G_gandalf = false

    --declaration des variables globales de controle
    --- @type Hitbox[]
    G_hitboxes = {}
    --- @type Hitbox[]
    G_hurtboxes = {}
    --- @type Projectile[]
    G_projectiles = {}
    --- @type Item[]|Coin[]|Weapon[]|Consumable[]
    G_itemList = {}
    --- @type Monster[]
    G_monsterList = {}
    G_hitboxActivated = true

    G_soundOn = true
    G_soundEffectsOn = true

    G_room = Room:new(0, true)
    G_deltaT = 0

    --- @type Element[]
    G_deadElements = {}

    G_nbRooms = 3

    -- G_player because player is a global variable
    G_player = Player:new()
    -- Arguments speed, weapon, pos, spriteCollection, , hbWidth, hbHeight, hbOffset
    -- speed and weapon are specific to entities while pos, spriteCollection, hbWidth, hbHeight and hbOffset are for all sprites
    G_player:init({}, 15, 1, "epee", Vector:new(152,80), Data.playerSC, Data.playerHF)

    G_hud = Hud:new()
end

function love.keypressed(k)
    if G_PONG then if k == "escape" then love.event.quit() else return end end

    G_hud:keypressed(k)
    -- Attaque
    if k == "space" and G_player.state ~= "special" and #G_player.inventory > 0 then
        G_player:changeState("attack")

    -- Potion
    elseif k == "a" then
        G_player:applyPotionEffect(3) -- TODO: This value should be linked to the potion .value attribute

    -- Compétence
    elseif k == "e" and G_player.currentEnergy > 9.9 and #G_player.inventory > 0 then
        G_player:changeState("special")

    elseif k == "v" then
        print(G_player.score.getScore())

    elseif k == "escape" then
        love.event.quit()
    end
end

--- Converts a polar coordinate to a cartesian coordinate.
--- @param x number
--- @param y number
function G_cartToCyl(x, y) return Vector:new(math.sqrt(x*x + y+y),  math.atan(y / x)) end

--- Converts a cartesian coordinate to a polar coordinate.
--- @param theta number theta en radian :  math.atan(y / x)
--- @param r number|nil longueur : math.sqrt(x*x + y+y)
function G_cylToCart(theta, r)
    r = r or 1
    return Vector:new(r * math.cos(theta),  r * math.sin(theta))
end

-- Check if a layers1 and layers2 have a common element
--- @param layers1 table<string, boolean|nil>
--- @param layers2 table<string, boolean|nil>
local function haveCommonElement(layers1, layers2)
    for k, v in pairs(layers1) do
        if layers2[k] then
            return true
        end
    end
    return false
end

local function checkHurtHit()
    for i, v in ipairs(G_hurtboxes) do
        for i2, v2 in ipairs(G_hitboxes) do
            if v:collide(v2) then
                if v2.associatedElement ~= -1 and haveCommonElement(v.layers, v2.layers) then
                    local isDead = v2.associatedElement:hurt(v.associatedElement.damage, v.associatedElement.pos)
                    if isDead and v2.layers["enemy"] then
                        if v2.associatedElement.name == "troll" then
                            G_player.score.addScore("killedTroll")
                        elseif v2.associatedElement.name == "rhino" then
                            G_player.score.addScore("killedRhino")
                        end
                        v2.associatedElement.lootTable:loot(v2.associatedElement.pos)
                    end
                    if tostring(v.associatedElement) == "Projectile" then v.associatedElement:hurt(1)
                end
                elseif tostring(v.associatedElement) == "Projectile" and v2.layers["tile"] then
                    v.associatedElement:hurt(1)
                end
            end
        end
    end
end

local function delete(element)
    for i, v in ipairs(G_hitboxes) do
        if v.associatedElement == element then
            table.remove(G_hitboxes, i)
        end
    end
    for i, v in ipairs(G_hurtboxes) do
        if v.associatedElement == element then
            table.remove(G_hurtboxes, i)
        end
    end
end

local function deleteFromList(list, element)
    for i, v in ipairs(list) do
        if v == element then
            table.remove(list, i)
            break
        end
    end

    for i, v in pairs(G_hitboxes) do
        if v == element.hitboxes["hitbox"] then
            table.remove(G_hitboxes, i)
            break
        end
    end

    for i, v in pairs(G_hurtboxes) do
        if v == element.hitboxes["hurtbox"] then
            table.remove(G_hurtboxes, i)
            break
        end
    end
end

local function killEntities()
    -- TODO: This is not optimized, should be replaced with a globalID system.
    for k, v in pairs(G_deadElements) do
        if tostring(v) == "Projectile" then deleteFromList(G_projectiles, v)
        elseif tostring(v) == "Monster" then deleteFromList(G_monsterList, v)
        elseif tostring(v) == "Consumable" then deleteFromList(G_itemList, v)
        elseif tostring(v) == "Coin" then deleteFromList(G_itemList, v)
        elseif tostring(v) == "Weapon" then deleteFromList(G_itemList, v)
        elseif tostring(v) == "Item" then deleteFromList(G_itemList, v)
        elseif tostring(v) == "Player" then delete(v)
            G_player:changeState("idle")
            G_hud.player:setVisible(false)
            G_hud.defeat:setVisible(true)
            G_room.music:pause()
        else print("Unknown Element: " .. tostring(v)) end
    end
    G_deadElements = {}
end

--- Update the game (called every frames)
--- @param dt number the time elapsed since the last frame
function love.update(dt)

    G_hud:update(dt) -- HUD
    if G_hud.player.visible then --jeu en cours

        if not G_room.isFinished then
            --INPUTS
            --affichage des hitboxes
            if love.keyboard.isDown("lshift") then
                G_hitboxActivated = true
            else
                G_hitboxActivated = false
            end

            --affichage du radius de collect
            if love.keyboard.isDown("lctrl") then
                G_player.radiusDisplay = true
            else
                G_player.radiusDisplay = false
            end

            if love.keyboard.isDown("lalt") then
                for i, v in pairs(G_monsterList) do
                    G_monsterList[i].radiusDisplay = true
                end
            else
                for i, v in pairs(G_monsterList) do
                    G_monsterList[i].radiusDisplay = false
                end
            end

            if love.keyboard.isDown("1") then
                G_player.currentPotion = 1 --health
            end
            if love.keyboard.isDown("2") then
                G_player.currentPotion = 2 --speed
            end
            if love.keyboard.isDown("3") then
                G_player.currentPotion = 3 --damage
            end


            if G_PONG then
                Pong.update(dt)
                return
            end

            if love.keyboard.isDown("p") and love.keyboard.isDown("i") and love.keyboard.isDown("n") and love.keyboard.isDown("g") then
                Pong = require("tests/pong/pong")
                Pong.load()
                G_PONG = true
            end

            -- player movements
            G_player:update(dt)

            for i, v in ipairs(G_projectiles) do
                v:update(dt)
            end

            -- Monster updates
            for i = 1,#G_monsterList do
                if G_monsterList[i] then
                    G_monsterList[i].goal = G_player.pos
                    G_monsterList[i]:update(dt, G_player)
                end
            end

            --updating all the items of the game
            for i = 1,#G_itemList do
                if G_itemList[i] then
                    G_itemList[i]:update(dt)
                end
            end

            --trying to pick up item
            for i = 1,#G_itemList do
                if G_itemList[i] then
                    if G_player:pickup(G_itemList[i]) then
                        if tostring(G_itemList[i]) == "Coin" then
                            if G_soundEffectsOn then
                                local coin=love.audio.newSource("sound/soundeffects/coin.wav","static")
                                coin:setVolume(0.2)
                                coin:play()
                            end
                        else
                            if G_soundEffectsOn then
                                local item=love.audio.newSource("sound/soundeffects/pickup.wav", "static") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
                                item:setVolume(0.2)
                                item:play()
                            end
                        end

                        for j = 1,#G_hitboxes do
                            if G_hitboxes[j] == G_itemList[i].hitboxes["hitbox"] then
                                table.remove(G_hitboxes, j)
                                break
                            end
                        end
                        table.remove(G_itemList, i)
                        break
                    end
                end
            end


            -- make the exit of the room appear
            if #G_monsterList == 0 then
                G_room.objectsGrid[G_room.exit["row"]][G_room.exit["col"]].data=7
                if G_room.number ~= 0 and G_hud.questTexts.elements["level_end"].enabled then
                    G_hud.questTexts.elements["level_end"]:setLifeSpan(4)
                end
                if G_player.pos.x > G_room.exit["col"]*G_room.tileSize and G_player.pos.x < (G_room.exit["col"]+1)*G_room.tileSize then
                    if G_player.pos.y > G_room.exit["row"]*G_room.tileSize and G_player.pos.y < (G_room.exit["row"]+1)*G_room.tileSize then
                        G_room.isFinished = true
                        if G_deltaT == 0 then
                            G_player.score.addScore("roomFinished", G_room.number)
                            G_deltaT = love.timer.getTime()
                            -- G_hud.player:setVisible(false)
                            G_room.music:pause()
                            if G_soundOn then
                                local won = love.audio.newSource("sound/soundeffects/change_room.wav", "static") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
                                won:setVolume(0.5)
                                won:play()

                            end

                        end
                    end
                end
            end

            checkHurtHit()

            killEntities()

        --to change room if room is finished
        else

            if love.timer.getTime() - G_deltaT > 1 then
                local index = G_room.number+1
                if G_room.number == 0 then
                    G_hud.questTexts.elements["tempText"]:setLifeSpan(4)
                    G_hud.questTexts.elements["tuto"]:setVisible(false)
                    G_hud.questTexts.elements["tuto"].forceOff = true
                    G_hud.questTexts.elements["tutoEnd"].forceOff = true
                    G_hud.questTexts.elements["tir"].forceOff = true

                end
                if G_room.number == 2 then
                    G_hud.questTexts.elements["tempText"]:reset()
                    G_hud.questTexts.elements["level_end"]:reset()
                elseif G_room.number == 1 or G_room.number == 3 then
                    G_hud.questTexts.elements["level_end"]:reset()
                    G_hud.questTexts.elements["tempText"]:reset(4)
                end

                if index > G_nbRooms then
                    print("Victory")
                    G_hud.player:setVisible(false)
                    G_hud.victory:setVisible(true)
                else
                    --reset G_variables
                    G_resetGVariable(index)
                end
            end
        end
    end
end

function G_resetGVariable(roomIndex)
    local Data = require("data")
    G_hurtboxes = {}
    G_monsterList = {}
    G_itemList = {}
    G_projectiles = {}
    G_room = nil
    G_deltaT = 0
    G_blackoutOnPlayer = false
    G_blackoutCurrentFrame = 250

    -- G_hud.player:setVisible(true)
    if roomIndex == 0 then -- new game
        G_hitboxes = {}
        G_room = Room:new(roomIndex, true)
        -- TODO: !!!!!!! reset player !!!!!!! -- health, hitbox, potions ...
        G_player:init({}, 15, 1, "epee", Vector:new(152,80), Data.playerSC, Data.playerHF)
    else
        G_hitboxes = {G_player.hitboxes["hitbox"]}
        G_room = Room:new(roomIndex)
    end
end

--- Draw the game (called every frames)
function love.draw()
    if G_deltaT ~= 0 then
        love.graphics.setColor(255/255, 255/255, 255/255)

    elseif G_hud.player.visible or G_hud.parameter.visible or G_hud.characterSheet.visible then --menu de départ => jeu non affiché
        love.graphics.setColor(255/255, 255/255, 255/255)
        if G_PONG then
            love.graphics.scale(1, 1)
            Pong.draw()
            return
        end

        love.graphics.scale(4, 4)
        if G_blackoutOnPlayer then
            love.graphics.setColor(G_blackoutCurrentFrame/255, G_blackoutCurrentFrame/255, G_blackoutCurrentFrame/255)
        end

        if G_blackoutOnPlayer then
            love.graphics.setColor(255/255, 255/255, 255/255)
        end

        if G_blackoutOnPlayer then
            love.graphics.setColor(G_blackoutCurrentFrame/255, G_blackoutCurrentFrame/255, G_blackoutCurrentFrame/255)
        end
        G_room:draw()
        G_player:draw()

        -- drawing Monsters
        for i = 1,#G_monsterList do
            if G_monsterList[i] then
                G_monsterList[i]:draw()
            end
        end

        --drawing Items on the map
        for i = 1,#G_itemList do
            if G_itemList[i] then
                G_itemList[i]:draw()
            end
        end

        for i, v in ipairs(G_projectiles) do
            v:draw()
        end

        if G_hitboxActivated then
            for i, v in ipairs(G_hitboxes) do
                v:draw({0, 255, 255})
            end

            for i, v in ipairs(G_hurtboxes) do
                v:draw({255, 255, 0})
            end
        end

        love.graphics.scale(1/4, 1/4)
    end
  --  love.graphics.setColor(255/255, 255/255, 255/255)
    G_hud:draw()
end
