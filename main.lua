-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- Pour notre magnifique HUD
local Hud = require("hud/hud")

local function onPanelHover(pState)
  print("Panel is hover:"..pState)
end

local function onCheckboxSwitch(pState)
  print("Switch is:"..pState)
end

local mainFont = love.graphics.newFont("sprites/hud/kenvector_future_thin.ttf", 15)
love.graphics.setFont(mainFont)

function love.load()
    love.graphics.setBackgroundColor(55, 55, 55)
    love.graphics.setDefaultFilter("nearest", "nearest")
    Player = require("player")
    G_player = Player:new("wizard_idle_01.png")
    G_player.health = 10

    G_hud = Hud:new()
    -- print(G_hud.player[14]) debug A ne pas supprimer
end

-- A ne pas supprimer => mais ça ne marche pas encore (lien avec HUD)
-- function love.keypressed(k)
--   if k == "m" then
--     G_hud.player["healthBar"]:modifyValue(2)
--   elseif k == "l" then
--     G_hud.player["healthBar"]:modifyValue(-2)
--   end
-- end

function love.update(dt)
    G_hud:update(dt) -- HUD
    G_player:update() -- player movements
end

function love.draw()
    G_hud:draw()
    love.graphics.scale(4, 4)
    G_player:draw()
end
