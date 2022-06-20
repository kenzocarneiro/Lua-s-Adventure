if arg[#arg] == "vsc_debug" then require("lldebugger").start() end
local myGUI = require("GUI")

local groupTest

function love.conf(t)
    t.window.width = 1000
    t.window.height = 800
    t.window.title = "My game!"
end

function love.load()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setDefaultFilter("nearest", "nearest")
    Player = require("player")
    player = Player:new("wizard_idle_01.png")
    player.health = 10

    panelTest1 = myGUI.newPanel(10, 350, 300, 200)
    groupTest = myGUI.newGroup()
    groupTest:addElement(panelTest1)
  
    --panelTest1 = myGUI.newPanel(10, 350)  
   -- panelTest1:setImage(love.graphics.newImage("sprites/hud/panel1.png"))
  
  
    groupTest:addElement(panelTest1)
end

function love.update(dt)
    -- player movements
    player:update()
end

function love.draw()
    love.graphics.scale(4, 4)
    player:draw()
    groupTest:draw()
end