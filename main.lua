-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- Pour notre magnifique HUD
local Group = require("hud/group")
local Panel = require("hud/panel")

local groupTest

function love.conf(t)
    t.window.width = 1920
    t.window.height = 1080
    t.window.title = "My game!"
end

function love.load()
   -- love.graphics.setBackgroundColor(55, 55, 55)
    love.graphics.setDefaultFilter("nearest", "nearest")
    Player = require("player")
    player = Player:new("wizard_idle_01.png")
    player.health = 10

    healthHeart = Panel:new(0, 10, 10, 10)
    healthHeart:setImage(love.graphics.newImage("sprites/hud/health.png"))
    
    
    --pos x, pos y, largeur, longueur, max, couleur ext, couleur int
   -- healthBar = myGUI.newProgressBar(100,100, 220, 26, 100,    {50,50,50}, {250, 129, 50})

   panelTest1 = Panel:new(10, 220, 300, 200)
   panelTest1:setImage(love.graphics.newImage("sprites/hud/panel1.png"))

    groupTest = Group:new()
    groupTest:addElement(panelTest1)

    groupTest:addElement(healthHeart)
    
end

function love.update(dt)
    -- player movements
    player:update()
   -- if healthBar.Value > 0 then
   --     healthBar:setValue(healthBar.Value - 0.01)
   --   end
   groupTest:update(dt)
  
   
 
end

function love.draw()
    love.graphics.scale(4, 4)
    player:draw()
    groupTest:draw()

end