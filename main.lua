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
    player:init("wizard_idle_01.png", false, 18, 18)
end

function love.update(dt)
    -- player movements
    player:update()
end

function love.draw()
    love.graphics.scale(4, 4)
    player:draw()
end