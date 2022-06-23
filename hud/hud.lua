local Bar = require("hud/bar")
local Button = require("hud/button")
local Checkbox = require("hud/checkbox")
local Group = require("hud/group")
local Panel = require("hud/panel")
local Text = require("hud/text")
local myGUI = require("GCGUI")

local Hud = {}

function Hud:new()
    self.__index = self
    local myHud = {}
    setmetatable(myHud, self)


    myHud.player = self.drawPlayer()

    return myHud
end

function Hud.drawPlayer()
    local mainFont = love.graphics.newFont("sprites/hud/kenvector_future_thin.ttf", 15)
    love.graphics.setFont(mainFont)

    local group = Group:new()

    -- tests du HUD
    local healthHeart = Panel:new(0, 0)
        healthHeart:setImage(love.graphics.newImage("sprites/hud/health.png"), 0.1)

    local healthBar = Bar:new(35,10, 164, 22, 10, nil,{0,255,0})

   -- G_button = Button:new(55, 100, 120, 80,"No images", mainFont, {250, 250, 250})
  --  print("g button h :" .. G_button.h)

  -- test bibliothèque
  
    local largeur = love.graphics.getWidth()
    local hauteur = love.graphics.getHeight()
  
    local skill_1 = myGUI.newButton(0, hauteur - 64, 40, 40,"", mainFont, {151, 220, 250})
        skill_1:setImages(love.graphics.newImage("sprites/hud/health_potion.png"))
        skill_1:setEvent("")

    local buttonParam = myGUI.newButton(largeur -60 , hauteur - 70, 16, 16,"", mainFont, {255, 0, 0})
        buttonParam:setImages(love.graphics.newImage("sprites/hud/gear2.jpg"))

    local skill_2 = myGUI.newButton(65, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
        skill_2:setImages(love.graphics.newImage("sprites/hud/skilll_1.png"))

    local skill_3 = myGUI.newButton(130, hauteur - 65, 40, 40,"", mainFont, {0, 255, 0})
        skill_3:setImages(love.graphics.newImage("sprites/hud/boom.png"))
  
    local offset = largeur / 2
    local distanceBetweenInvSlot = 65

    local inventory_slot_1 = myGUI.newButton(offset - distanceBetweenInvSlot * 2, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
        inventory_slot_1:setImages(love.graphics.newImage("sprites/hud/blank_slot.png"))

    local inventory_slot_2 = myGUI.newButton(offset - distanceBetweenInvSlot, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
        inventory_slot_2:setImages(love.graphics.newImage("sprites/hud/blank_slot.png"))
    
    local inventory_slot_3 = myGUI.newButton(offset, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
        inventory_slot_3:setImages(love.graphics.newImage("sprites/hud/blank_slot.png"))
    
    local inventory_slot_4 = myGUI.newButton(offset +distanceBetweenInvSlot, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
        inventory_slot_4:setImages(love.graphics.newImage("sprites/hud/blank_slot.png"))
    
    local inventory_slot_5 = myGUI.newButton(offset +distanceBetweenInvSlot *2, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
        inventory_slot_5:setImages(love.graphics.newImage("sprites/hud/blank_slot.png"))

    local title1 = myGUI.newText(skill_1.W/2 , hauteur - skill_1.H -20, 0, 0,"A", mainFont, "", "", {25, 150, 25})
  
    local title2 = myGUI.newText(skill_1.W/2 + skill_2.W , hauteur - skill_1.H -20, 0, 0,"E", mainFont, "", "", {25, 150, 25})

    local title3 = myGUI.newText(skill_1.W/2 + skill_2.W*2 , hauteur - skill_1.H -20, 0, 0,"T", mainFont, "", "", {25, 150, 25})
    
    group:addElement(skill_3, "skill_3")
    
    group:addElement(skill_2, "skill_2")
    group:addElement(skill_1, "skill_1")
    group:addElement(title1, "title1")
    group:addElement(title2, "title2")
    group:addElement(title3, "title3")

    group:addElement(inventory_slot_1, "inventory_slot_1")
    group:addElement(inventory_slot_2, "inventory_slot_2")
    group:addElement(inventory_slot_3, "inventory_slot_3")
    group:addElement(inventory_slot_4, "inventory_slot_4")
    group:addElement(inventory_slot_5, "inventory_slot_5")

    group:addElement(buttonParam, "buttonParam")

    
    group:addElement(healthBar, "healthBar")
    group:addElement(healthHeart, "healthHeart")

    return group
end

function Hud:keypressed(k)
    if k == "m" then
        G_hud.player.elements["healthBar"]:modifyValue(2)
    elseif k == "l" then
        G_hud.player.elements["healthBar"]:modifyValue(-2)
    end
end

function Hud:update(dt)
    self.player:update(dt)
end

function Hud:draw()
    self.player:draw()
    
    love.graphics.setColor(1,1,1)
end


-- function Hud:__tostring()
--     for key, value in pairs(self) do
        
--     end
-- end

return Hud

-- local function onPanelHover(pState)
--   print("Panel is hover:"..pState)
-- end

-- local function onCheckboxSwitch(pState)
--   print("Switch is:"..pState)
-- end

