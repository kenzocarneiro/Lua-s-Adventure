if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

function love.conf(t)
    t.window.width = 1000
    t.window.height = 800
    t.window.title = "My game!"
end

function love.load()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setDefaultFilter("nearest", "nearest")
    local Player = require("player")
    G_player = Player:new()

    -- Args : speed, weapon, pos, img, isSheet, width, height, hbWidth, hbHeight, hbOffset
    -- G_player because player is a global variable
    G_player:init(1, "epee", Vector:new(100, 100), "sprites/wizard_idle-Sheet.png", true, 18, 18, 5, 10, Vector:new(0, 3))
end

function love.update(dt)
    -- player movements
    G_player:update(dt)
end

function love.draw()
    love.graphics.scale(4, 4)
    G_player:draw(true)
end