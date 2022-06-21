-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- Pour notre magnifique HUD
local Group = require("hud/group")
local Panel = require("hud/panel")

function love.conf(t)
    t.window.width = 1920
    t.window.height = 1080
    t.window.title = "My game!"
end

function love.load()
    love.graphics.setBackgroundColor(55, 55, 55)
    love.graphics.setDefaultFilter("nearest", "nearest")
    Player = require("player")
    G_player = Player:new("wizard_idle_01.png")
    G_player.health = 10

    G_healthHeart = Panel:new(0, 0)
    G_healthHeart:setImage(love.graphics.newImage("sprites/hud/health.png"), 0.1)
    
    
    --pos x, pos y, largeur, longueur, max, couleur ext, couleur int
    -- healthBar = myGUI.newProgressBar(100,100, 220, 26, 100,    {50,50,50}, {250, 129, 50})

    G_panelTest1 = Panel:new(10, 50)
    G_panelTest1:setImage(love.graphics.newImage("sprites/hud/panel1.png"), 0.1)

    G_groupTest = Group:new()
    G_groupTest:addElement(G_panelTest1)

    G_groupTest:addElement(G_healthHeart)
    
end

function love.update(dt)
    -- player movements
    G_player:update()
   -- if healthBar.Value > 0 then
   --     healthBar:setValue(healthBar.Value - 0.01)
   --   end
   G_groupTest:update(dt)
end

function love.draw()
    love.graphics.scale(4, 4)
    G_player:draw()
    G_groupTest:draw()

end