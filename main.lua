-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- Pour notre magnifique HUD
local Hud = require("hud/hud")
G_eltCounter = 0


local mainFont = love.graphics.newFont("sprites/hud/kenvector_future_thin.ttf", 15)
love.graphics.setFont(mainFont)


--- Load the game
function love.load()
    math.randomseed(os.time())
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setDefaultFilter("nearest", "nearest")
    local Player = require("entity/player")
    local Monster = require("entity/monster")
    local Room = require("Room")
    local Item = require("item")
    local Vector = require("vector")
    local Sprite = require("sprite/sprite")
    local SpriteCollection = require("sprite/spriteC")
    local Consumable = require("consumable")
    local Coin = require("coin")
    local Weapon = require("weapon")
    local HitboxFactory = require("hitboxF")

    G_fireballSC = SpriteCollection:new("fireball")
    G_fireballSC:init({Sprite:new("img/fireball-Sheet.png", true, "idle", 10, 7, Vector:new(8, 4))})

    G_fireballHF = HitboxFactory:new({"hurtbox", {enemy=true}, 3, 3, Vector:new(-2, -2)})

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

    G_room = Room:new(1)

    --- @type Element[]
    G_deadElements = {}

    --initialize sprite collections for monster player and item
    local player_sc = SpriteCollection:new("player")
    player_sc:init({Sprite:new("img/wizard_idle-Sheet.png", true, "idle", 18, 18, Vector:new(7, 9)),
        Sprite:new("img/wizard_run-Sheet.png", true, "run", 18, 18, Vector:new(7, 9)),
        Sprite:new("img/wizard_attack-Sheet.png", true, "attack", 18, 18, Vector:new(7, 9))})

    local playerHF = HitboxFactory:new(
        -- {"hurtbox", {enemy=true}, 5, 5, Vector:new(-5, -5)},
        {"hitbox", {player=true}, 4, 10, Vector:new(-2, -2)}
    )

    --MONSTERS
    local troll_sc = SpriteCollection:new("troll")
    troll_sc:init({Sprite:new("img/troll_idle-Sheet.png", true, "idle", 16, 16, Vector:new(7, 6))})


    local rhino_sc = SpriteCollection:new("rhino")
    rhino_sc:init({Sprite:new("img/rhino_idle-Sheet.png", true, "idle", 16, 16, Vector:new(7, 6))})


    local trollHF = HitboxFactory:new(
        {name="hitbox", layers={enemy=true}, width=5, height=11, offset=Vector:new(-2, -2)}
    )

    local rhinoHF = HitboxFactory:new(
        {name="hitbox", layers={enemy=true}, width=4, height=7, offset=Vector:new(-3, 1)}
    )

    --STAFFS
    local cool_staff_sc = SpriteCollection:new("item")
    cool_staff_sc:init({Sprite:new("img/magic_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local cool_staffHF = HitboxFactory:new(
        {"hitbox", {item=true}, 3, 14, Vector:new(-5, -5)}
    )

    local simple_staff_sc = SpriteCollection:new("item")
    simple_staff_sc:init({Sprite:new("img/simple_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local simple_staffHF = HitboxFactory:new(
        {"hitbox", {item=true}, 3, 10, Vector:new(-6, -5)}
    )

    local gold_staff_sc = SpriteCollection:new("item")
    gold_staff_sc:init({Sprite:new("img/gold_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local gold_staffHF = HitboxFactory:new(
        {"hitbox", {item=true}, 3, 14, Vector:new(-5, -5)}
    )

    local power_staff_sc = SpriteCollection:new("item")
    power_staff_sc:init({Sprite:new("img/power_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local power_staffHF = HitboxFactory:new(
        {"hitbox", {item=true}, 3, 13, Vector:new(-5, -4)}
    )

    --POTIONS
    local bluePotionSc = SpriteCollection:new("consumable")
    bluePotionSc:init({Sprite:new("img/potion_blue.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local redPotionSc = SpriteCollection:new("consumable")
    redPotionSc:init({Sprite:new("img/potion_red.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local yellowPotionSc = SpriteCollection:new("consumable")
    yellowPotionSc:init({Sprite:new("img/potion_yellow.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local bluePotionHF = HitboxFactory:new(
        {"hitbox", {item=true}, 5, 6, Vector:new(-6, -5)}
    )

    local redPotionHF = HitboxFactory:new(
        {"hitbox", {item=true}, 5, 6, Vector:new(-6, -5)}
    )

    local yellowPotionHF = HitboxFactory:new(
        {"hitbox", {item=true}, 5, 6, Vector:new(-6, -5)}
    )

    --COIN
    local coinSc = SpriteCollection:new("coin")
    coinSc:init({Sprite:new("img/coin.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local coinHF = HitboxFactory:new(
        {"hitbox", {item=true}, 6, 8, Vector:new(-6, -6)}
    )


    -- G_player because player is a global variable
    G_player = Player:new()
    -- Arguments speed, weapon, pos, spriteCollection, , hbWidth, hbHeight, hbOffset
    -- speed and weapon are specific to entities while pos, spriteCollection, hbWidth, hbHeight and hbOffset are for all sprites
    G_player:init({}, 15, 1, "epee", Vector:new(100, 100), player_sc, playerHF)
    G_hitboxes[#G_hitboxes+1] = G_player.hitboxes["hitbox"]

    local troll = Monster:new()
    troll:init("advanced", 0.5, 0.5, "epee", Vector:new(70, 80), troll_sc, trollHF)
    G_hitboxes[#G_hitboxes+1] = troll.hitboxes["hitbox"]
    G_monsterList[#G_monsterList+1] = troll

    local rhino = Monster:new()
    rhino:init("simple", 0.5, 0.7, "epee", Vector:new(150, 150), rhino_sc, rhinoHF)
    G_hitboxes[#G_hitboxes+1] = rhino.hitboxes["hitbox"]
    G_monsterList[#G_monsterList+1] = rhino


    local speedPotion = Consumable:new()
    speedPotion:init("speed", 0.5, "potion of speed", Vector:new(250, 150), bluePotionSc, bluePotionHF)
    G_hitboxes[#G_hitboxes+1] = speedPotion.hitboxes["hitbox"]
    G_itemList[#G_itemList+1] = speedPotion

    local healthPotion = Consumable:new()
    healthPotion:init("health", 1, "potion of heatlh", Vector:new(30, 150), redPotionSc, redPotionHF)
    G_hitboxes[#G_hitboxes+1] = healthPotion.hitboxes["hitbox"]
    G_itemList[#G_itemList+1] = healthPotion

    local damagePotion = Consumable:new()
    damagePotion:init("damage", 1, "potion of health", Vector:new(30, 50), yellowPotionSc, yellowPotionHF)
    G_hitboxes[#G_hitboxes+1] = damagePotion.hitboxes["hitbox"]
    G_itemList[#G_itemList+1] = damagePotion

    local goldCoin = Coin:new()
    goldCoin:init(3, "coin of gold", Vector:new(200, 20), coinSc, coinHF)
    G_hitboxes[#G_hitboxes+1] = goldCoin.hitboxes["hitbox"]
    G_itemList[#G_itemList+1] = goldCoin

    local simple_staff = Weapon:new()
    simple_staff:init(1, "AXE !", Vector:new(90, 70), simple_staff_sc, simple_staffHF)
    G_hitboxes[#G_hitboxes+1] = simple_staff.hitboxes["hitbox"]
    G_itemList[#G_itemList+1] = simple_staff

    local cool_staff = Weapon:new()
    cool_staff:init(2, "AXE !", Vector:new(200, 90), cool_staff_sc, cool_staffHF)
    G_hitboxes[#G_hitboxes+1] = cool_staff.hitboxes["hitbox"]
    G_itemList[#G_itemList+1] = cool_staff

    local power_staff = Weapon:new()
    power_staff:init(5, "AXE !", Vector:new(80, 40), power_staff_sc, power_staffHF)
    G_hitboxes[#G_hitboxes+1] = power_staff.hitboxes["hitbox"]
    G_itemList[#G_itemList+1] = power_staff

    local gold_staff = Weapon:new()
    gold_staff:init(10, "AXE !", Vector:new(250, 40), gold_staff_sc, gold_staffHF)
    G_hitboxes[#G_hitboxes+1] = gold_staff.hitboxes["hitbox"]
    G_itemList[#G_itemList+1] = gold_staff


    G_hud = Hud:new()
    -- print(G_hud.player[14]) debug A ne pas supprimer
end

function love.keypressed(k)
    G_hud:keypressed(k)
    if k == "space" then
        if G_soundEffectsOn then
            local sound = love.audio.newSource("sound/soundeffects/player_attack.ogg", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
            sound:setVolume(3)
            sound:play()
        end
        G_player:changeState("attack")
        --print("BOOM")
    elseif k == "i" then
        for i, v in ipairs(G_player.inventory) do
            --print(i, v)
        end
    elseif k == "escape" then
        love.event.quit()
    end
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
                    v2.associatedElement:hurt(v.associatedElement.damage)
                end
                if tostring(v.associatedElement) == "Projectile" and not v2.layers["item"] then
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
            return
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
        else print("Unknown Element: " .. tostring(v)) end
    end
    G_deadElements = {}
end

--- Update the game (called every frames)
--- @param dt number the time elapsed since the last frame
function love.update(dt)
    G_hud:update(dt) -- HUD

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
            G_monsterList[i]:update(dt)
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
                if tostring(G_player.inventory[#G_player.inventory]) == "Coin" then
                    G_player.gold = G_player.gold + G_itemList[i].value
                    table.remove(G_player.inventory, #G_player.inventory)
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

    checkHurtHit()

    killEntities()
end

--- Draw the game (called every frames)
function love.draw()
    if G_PONG then
        love.graphics.scale(1, 1)
        Pong.draw()
        return
    end
    love.graphics.scale(4, 4)
    G_room:draw(G_hitboxActivated)

    G_player:draw(G_hitboxActivated)

    -- drawing Monsters
    for i = 1,#G_monsterList do
        if G_monsterList[i] then
            G_monsterList[i]:draw(G_hitboxActivated)
        end
    end

    --drawing Items on the map
    for i = 1,#G_itemList do
        if G_itemList[i] then
            G_itemList[i]:draw(G_hitboxActivated)
        end
    end

    for i, v in ipairs(G_projectiles) do
        v:draw(G_hitboxActivated)
    end

    love.graphics.scale(1/4, 1/4)
    G_hud:draw()

end
