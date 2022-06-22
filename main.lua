if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

--- Load the game
function love.load()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setDefaultFilter("nearest", "nearest")
    local Player = require("entity/player")
    local Monster = require("entity/monster")
    local Sprite = require("sprite/sprite")
    local SpriteCollection = require("sprite/spriteC")
    local SpriteTimer = require("sprite/spriteTimer")
    local Item = require("item")

    --declaration des variables globales de controle
    G_hitboxes = {}
    G_itemList = {}
    G_monsterList = {}
    G_hitboxActivated = true

    --initialize sprite collections for monster player and item
    local player_sc = SpriteCollection:new("player")
    player_sc:init({Sprite:new("img/wizard_idle-Sheet.png", true, "idle", 18, 18, Vector:new(7, 9)),
        Sprite:new("img/wizard_run-Sheet.png", true, "run", 18, 18, Vector:new(7, 9)),
        Sprite:new("img/wizard_attack-Sheet.png", true, "attack", 18, 18, Vector:new(7, 9))})

    local monster_sc = SpriteCollection:new("monster")
    monster_sc:init({Sprite:new("img/troll_idle-Sheet.png", true, "idle", 16, 16, Vector:new(7, 6))})

    local item_sc = SpriteCollection:new("item")
    item_sc:init({Sprite:new("img/axe.png", false, "idle", 16, 16, Vector:new(7, 6))})


    -- G_player because player is a global variable
    G_player = Player:new()
    -- Arguments speed, weapon, pos, spriteCollection, , hbWidth, hbHeight, hbOffset
    -- speed and weapon are specific to entities while pos, spriteCollection, hbWidth, hbHeight and hbOffset are for all sprites
    G_player:init({}, 15, 1, "epee", Vector:new(120, 120), player_sc, 5, 10, Vector:new(0, 3))
    G_hitboxes[#G_hitboxes+1] = G_player.hitbox

    local m = Monster:new()
    m:init(1, 1, "epee", Vector:new(70, 70), monster_sc, 5, 11, Vector:new(0, 3))
    G_hitboxes[#G_hitboxes+1] = m.hitbox
    G_monsterList[#G_monsterList+1] = m

    m = Monster:new()
    m:init(1, 1, "epee", Vector:new(150, 150), monster_sc, 5, 11, Vector:new(0, 3))
    G_hitboxes[#G_hitboxes+1] = m.hitbox
    G_monsterList[#G_monsterList+1] = m

    G_axe = Item:new()
    G_axe:init("AXE !", Vector:new(90, 90), item_sc, 5, 7, Vector:new(-3, -2))
    G_hitboxes[#G_hitboxes+1] = G_axe.hitbox
    G_itemList[#G_itemList+1] = G_axe
end


--- Update the game (called every frames)
--- @param dt number the time elapsed since the last frame
function love.update(dt)
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

    -- TO TEST, DELETE AFTER
    --kills a monster (to debug drop)
    if love.mouse.isDown(1) then 
        local index = 1
        if G_monsterList[index] then
            for j = 1,#G_hitboxes do
                if G_hitboxes[j] then
                    if G_hitboxes[j] == G_monsterList[index].hitbox then
                        G_hitboxes[j] = nil
                        break
                    end
                end
            end
            local i = G_monsterList[index]:drop()
            if i then
                G_hitboxes[#G_hitboxes+1] = i.hitboxes
                G_itemList[#G_itemList+1] = i
            end
            G_monsterList = G_monsterList[index]:die(G_monsterList)
        end
    end



    -- player movements
    G_player:update(dt)

    -- Monster updates
    for i = 1,#G_monsterList do
        if G_monsterList[i] then
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
                for j = 1,#G_hitboxes do
                    if G_hitboxes[j] == G_itemList[i].hitbox then
                        G_hitboxes[j] = nil
                    end
                end
                G_itemList[i] = nil
            end
        end
    end
end

--- Draw the game (called every frames)
function love.draw()
    love.graphics.scale(4, 4)
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
end