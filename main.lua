if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

--- Load the game
function love.load()
    math.randomseed(os.time())
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setDefaultFilter("nearest", "nearest")
    local Player = require("entity/player")
    local Monster = require("entity/monster")
    local Sprite = require("sprite/sprite")
    local SpriteCollection = require("sprite/spriteC")
    local SpriteTimer = require("sprite/spriteTimer")
    local Item = require("item")
    local Room = require("Room")

    --declaration des variables globales de controle
    G_hitboxes = {}
    G_itemList = {}
    G_monsterList = {}
    G_hitboxActivated = true
    G_room = Room:new(1)

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
    m:init(0.5, 1, "epee", Vector:new(70, 70), monster_sc, 5, 11, Vector:new(0, 3))
    G_hitboxes[#G_hitboxes+1] = m.hitbox
    G_monsterList[#G_monsterList+1] = m

    local m2 = Monster:new()
    m2:init(0.5, 1, "epee", Vector:new(150, 150), monster_sc, 5, 11, Vector:new(0, 3))
    G_hitboxes[#G_hitboxes+1] = m2.hitbox
    G_monsterList[#G_monsterList+1] = m2
    --DEBUG
    print("m1", G_hitboxes[#G_hitboxes-1])
    print("m2", G_hitboxes[#G_hitboxes])

    G_axe = Item:new()
    G_axe:init("AXE !", Vector:new(90, 90), item_sc, 5, 7, Vector:new(-3, -2))
    G_hitboxes[#G_hitboxes+1] = G_axe.hitbox
    G_itemList[#G_itemList+1] = G_axe
    print("axe", G_hitboxes[#G_hitboxes])

    G_axe2 = Item:new()
    G_axe2:init("AXE !", Vector:new(200, 90), item_sc, 5, 7, Vector:new(-3, -2))
    G_hitboxes[#G_hitboxes+1] = G_axe2.hitbox
    G_itemList[#G_itemList+1] = G_axe2
    print("axe", G_hitboxes[#G_hitboxes])
end

--- Update the game (called every frames)
--- @param dt number the time elapsed since the last frame
function love.update(dt)
    -- --DEBUG
    -- local to_find = G_monsterList[2].hitbox
    -- for i = 1,#G_hitboxes do
    --     if G_hitboxes[i] == to_find then
    --         print("FOUND")
    --     end
    -- end

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
                        print("kill monster", G_hitboxes[j])
                        table.remove(G_hitboxes, j)
                        break
                    end
                end
            end
            -- local i = G_monsterList[index]:drop()
            -- if i then
            --     G_hitboxes[#G_hitboxes+1] = i.hitbox
            --     G_itemList[#G_itemList+1] = i
            -- end
            G_monsterList = G_monsterList[index]:die(G_monsterList)
        end
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
                        print("supp item", G_hitboxes[j])
                        table.remove(G_hitboxes, j)
                    end
                end
                G_itemList[i] = nil
            end
        end
    end
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
end