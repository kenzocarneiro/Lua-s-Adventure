-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- Pour notre magnifique HUD
local Group = require("hud/group")
local Panel = require("hud/panel")
local Bar = require("hud/bar")
local Text = require("hud/text")
local Button = require("hud/button")

local myGUI = require("GCGUI")
local function onPanelHover(pState)
  print("Panel is hover:"..pState)
end

local function onCheckboxSwitch(pState)
  print("Switch is:"..pState)
end

local mainFont = love.graphics.newFont("sprites/hud/kenvector_future_thin.ttf", 15)
love.graphics.setFont(mainFont)
local Checkbox = require("hud/checkbox")

function love.load()
    love.graphics.setBackgroundColor(55, 55, 55)
    love.graphics.setDefaultFilter("nearest", "nearest")
    Player = require("player")
    G_player = Player:new("wizard_idle_01.png")
    G_player.health = 10

end

function love.update(dt)
    -- player movements
    G_player:update()
end

function love.draw()
    love.graphics.scale(4, 4)
    G_player:draw()

end
