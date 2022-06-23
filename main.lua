-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- Pour notre magnifique HUD
local Hud = require("hud/hud")



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

    G_fireballHF = HitboxFactory:new({"hitbox", {"projectiles"}, 3, 3, Vector:new(-2, -2)})

    --declaration des variables globales de controle
    --- @type Hitbox[]
    G_hitboxes = {}
    --- @type Projectile[]
    G_projectiles = {}
    --- @type Item[]|Coin[]|Weapon[]
    G_itemList = {}
    --- @type Monster[]
    G_monsterList = {}
    G_hitboxActivated = true
    G_room = Room:new(1)

    --initialize sprite collections for monster player and item
    local player_sc = SpriteCollection:new("player")
    player_sc:init({Sprite:new("img/wizard_idle-Sheet.png", true, "idle", 18, 18, Vector:new(7, 9)),
        Sprite:new("img/wizard_run-Sheet.png", true, "run", 18, 18, Vector:new(7, 9)),
        Sprite:new("img/wizard_attack-Sheet.png", true, "attack", 18, 18, Vector:new(7, 9))})

    local playerHF = HitboxFactory:new(
        -- {"hurtbox", {"enemy"}, 5, 5, Vector:new(-5, -5)},
        {"hitbox", {"player"}, 4, 10, Vector:new(-2, -2)}
    )

    local monster_sc = SpriteCollection:new("monster")
    monster_sc:init({Sprite:new("img/troll_idle-Sheet.png", true, "idle", 16, 16, Vector:new(7, 6))})

    local monsterHF = HitboxFactory:new(
        {name="hitbox", layers={"enemy"}, width=5, height=11, offset=Vector:new(-2, -2)}
    )

    local item_sc = SpriteCollection:new("item")
    item_sc:init({Sprite:new("img/axe.png", false, "idle", 16, 16, Vector:new(7, 6))})
    local itemHF = HitboxFactory:new(
        {"hitbox", {"item"}, 4, 7, Vector:new(-5, -5)}
    )

    local bluePotionSc = SpriteCollection:new("consumable")
    bluePotionSc:init({Sprite:new("img/potion_blue.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local redPotionSc = SpriteCollection:new("consumable")
    redPotionSc:init({Sprite:new("img/potion_red.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local yellowPotionSc = SpriteCollection:new("consumable")
    yellowPotionSc:init({Sprite:new("img/potion_yellow.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local bluePotionHF = HitboxFactory:new(
        {"hitbox", {"potion"}, 5, 6, Vector:new(-6, -5)}
    )

    local redPotionHF = HitboxFactory:new(
        {"hitbox", {"potion"}, 5, 6, Vector:new(-6, -5)}
    )

    local yellowPotionHF = HitboxFactory:new(
        {"hitbox", {"potion"}, 5, 6, Vector:new(-6, -5)}
    )

    local coinSc = SpriteCollection:new("coin")
    coinSc:init({Sprite:new("img/coin.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local coinHF = HitboxFactory:new(
        {"hitbox", {"coin"}, 6, 8, Vector:new(-6, -6)}
    )


    -- G_player because player is a global variable
    G_player = Player:new()
    -- Arguments speed, weapon, pos, spriteCollection, , hbWidth, hbHeight, hbOffset
    -- speed and weapon are specific to entities while pos, spriteCollection, hbWidth, hbHeight and hbOffset are for all sprites
    G_player:init({}, 15, 1, "epee", Vector:new(100, 100), player_sc, playerHF)
    G_hitboxes[#G_hitboxes+1] = G_player.hitboxes["hitbox"]

    local m = Monster:new()
    m:init(0.5, 0.5, "epee", Vector:new(70, 70), monster_sc, monsterHF)
    G_hitboxes[#G_hitboxes+1] = m.hitboxes["hitbox"]
    G_monsterList[#G_monsterList+1] = m

    local m2 = Monster:new()
    m2:init(0.5, 0.5, "epee", Vector:new(150, 150), monster_sc, monsterHF)
    G_hitboxes[#G_hitboxes+1] = m2.hitboxes["hitbox"]
    G_monsterList[#G_monsterList+1] = m2


    local speedPotion = Consumable:new()
    speedPotion:init("speed", 1, "potion of speed", Vector:new(250, 150), bluePotionSc, bluePotionHF)
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

    G_axe = Weapon:new()
    G_axe:init(5, "AXE !", Vector:new(90, 70), item_sc, itemHF)
    G_hitboxes[#G_hitboxes+1] = G_axe.hitboxes["hitbox"]
    G_itemList[#G_itemList+1] = G_axe

    G_axe2 = Weapon:new()
    G_axe2:init(5, "AXE !", Vector:new(200, 90), item_sc, itemHF)
    G_hitboxes[#G_hitboxes+1] = G_axe2.hitboxes["hitbox"]
    G_itemList[#G_itemList+1] = G_axe2

    G_hud = Hud:new()
    -- print(G_hud.player[14]) debug A ne pas supprimer
end

function love.keypressed(k)
    G_hud:keypressed(k)
    if k == "space" then
        G_player:changeState("attack")
        print("BOOM")
    elseif k == "i" then
        for i, v in ipairs(G_player.inventory) do
            print(i, v)
        end
    elseif k == "escape" then
        love.event.quit()
    end

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

    -- TO TEST, DELETE AFTER
    --kills a monster (to debug drop)
    if love.mouse.isDown(1) then
        local index = 1
        if G_monsterList[index] then
            for j = 1,#G_hitboxes do
                if G_hitboxes[j] then
                    if G_hitboxes[j] == G_monsterList[index].hitboxes["hitbox"] then
                        table.remove(G_hitboxes, j)
                        break
                    end
                end
            end
            local i = G_monsterList[index]:drop()
            if i then
                G_hitboxes[#G_hitboxes+1] = i.hitboxes["hitbox"]
                G_itemList[#G_itemList+1] = i
            end
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
                print("pickup")
                print(G_player.inventory[#G_player.inventory])
                if tostring(G_player.inventory[#G_player.inventory]) == "Coin" then
                    G_player.gold = G_player.gold + G_itemList[i].value
                    table.remove(G_player.inventory, #G_player.inventory)
                    print(G_player.gold)
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
        v:draw(true)
    end

    love.graphics.scale(1/4, 1/4)
    G_hud:draw()
end
