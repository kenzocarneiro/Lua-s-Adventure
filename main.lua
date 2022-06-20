if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

--- Load the game
function love.load()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setDefaultFilter("nearest", "nearest")
    local Player = require("player")
    local Sprite = require("sprite")
    local SpriteCollection = require("spriteC")


    local player_sc = SpriteCollection:new("player")
    player_sc:init({Sprite:new("sprites/wizard_idle-Sheet.png", true, "idle", 18, 18)})

    -- G_player because player is a global variable
    G_player = Player:new()
    -- Arguments speed, weapon, pos, spriteCollection, , hbWidth, hbHeight, hbOffset
    -- speed and weapon are specific to entities while pos, spriteCollection, hbWidth, hbHeight and hbOffset are for all sprites
    G_player:init(1, "epee", Vector:new(100, 100), player_sc, 5, 10, Vector:new(0, 3))
end


--- Update the game (called every frames)
--- @param dt number the time elapsed since the last frame
function love.update(dt)
    -- player movements
    G_player:update(dt)
end

--- Draw the game (called every frames)
function love.draw()
    love.graphics.scale(4, 4)
    G_player:draw(true)
end