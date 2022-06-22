-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- Pour notre magnifique HUD
local Group = require("hud/group")
local Panel = require("hud/panel")
local Bar = require("hud/bar")
local Checkbox = require("hud/checkbox")

function love.load()
    love.graphics.setBackgroundColor(55, 55, 55)
    love.graphics.setDefaultFilter("nearest", "nearest")
    Player = require("player")
    G_player = Player:new("wizard_idle_01.png")
    G_player.health = 10

    -- tests du HUD
    G_healthHeart = Panel:new(0, 0)
    G_healthHeart:setImage(love.graphics.newImage("sprites/hud/health.png"), 0.1)

    G_panelTest1 = Panel:new(10, 50)
    G_panelTest1:setImage(love.graphics.newImage("sprites/hud/panel1.png"), 0.1)

    G_healthBar = Bar:new(10,2, 41, 7, 10, nil,{0,255,0})

    G_checkbox = Checkbox:new(30, 30, 10, 10)
    G_checkbox:setImages(love.graphics.newImage("sprites/hud/dotGreen.png"), love.graphics.newImage("sprites/hud/dotRed.png"))

    G_groupTest = Group:new()
    G_groupTest:addElement(G_panelTest1)
    G_groupTest:addElement(G_healthBar)
    G_groupTest:addElement(G_healthHeart)
    G_groupTest:addElement(G_checkbox)

end

--test de la barre de vie
function love.keypressed(k)
    if k == "space" then
        G_healthBar:modifyValue(-2)
    end

    if k == "n" then
        G_healthBar:modifyValue(2)
    end

end


function love.update(dt)
    -- player movements
    G_player:update()
    G_groupTest:update(dt)
end

function love.draw()
    G_groupTest:draw()
    
    love.graphics.scale(4, 4)
    G_player:draw()
end
