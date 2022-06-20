if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

function love.conf(t)
    t.window.width = 1000
    t.window.height = 800
    t.window.title = "My game!"
end

function love.load()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setDefaultFilter("nearest", "nearest")
    Player = require("player")
    player = Player:new()
    player:init(100, 100, "sprites/wizard_idle-Sheet.png", true, 18, 18, 5, 10, 0, 3)
end

function love.update(dt)
    -- player movements
    player:update(dt)
end

function love.draw()
    love.graphics.scale(4, 4)
    player:draw(true)
end