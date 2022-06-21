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
    local Room = require("Room")

    G_hitboxes = {}

    G_room = Room:new(1)

    local player_sc = SpriteCollection:new("player")
    player_sc:init({Sprite:new("img/wizard_idle-Sheet.png", true, "idle", 18, 18, Vector:new(7, 9)),
        Sprite:new("img/wizard_run-Sheet.png", true, "run", 18, 18, Vector:new(7, 9)),
        Sprite:new("img/wizard_attack-Sheet.png", true, "attack", 18, 18, Vector:new(7, 9))})

    local monster_sc = SpriteCollection:new("monster")
    monster_sc:init({Sprite:new("img/troll_idle-Sheet.png", true, "idle", 16, 16, Vector:new(7, 6))})

    -- G_player because player is a global variable
    G_player = Player:new()
    -- Arguments speed, weapon, pos, spriteCollection, , hbWidth, hbHeight, hbOffset
    -- speed and weapon are specific to entities while pos, spriteCollection, hbWidth, hbHeight and hbOffset are for all sprites
    G_player:init(1, "epee", Vector:new(100, 100), player_sc, 5, 10, Vector:new(0, 10))

    G_monster = Monster:new()
    G_monster:init(1, "epee", Vector:new(50, 70), monster_sc, 20, 20, Vector:new(0, 3))

    G_monster2 = Monster:new()
    G_monster2:init(1, "epee", Vector:new(150, 130), monster_sc, 3, 3, Vector:new(0, 3))

    G_hitboxes[#G_hitboxes + 1] = G_player.hitbox
    G_hitboxes[#G_hitboxes + 1] = G_monster.hitbox
    G_hitboxes[#G_hitboxes + 1] = G_monster2.hitbox
end

--- Update the game (called every frames)
--- @param dt number the time elapsed since the last frame
function love.update(dt)
    -- player movements
    G_player:update(dt)
    G_monster:update(dt)
    G_monster2:update(dt)
end

--- Draw the game (called every frames)
function love.draw()
    love.graphics.scale(4, 4)
    G_room:draw(true)
    G_player:draw(true)
    G_monster:draw(true)
    G_monster2:draw(true)
end