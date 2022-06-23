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

    local healthBar = Bar:new(40,8, 164, 28, 10, nil,{0,255,0})

   -- G_button = Button:new(55, 100, 120, 80,"No images", mainFont, {250, 250, 250})
  --  print("g button h :" .. G_button.h)

  -- test bibliothèque
  
    local largeur = love.graphics.getWidth()
    local hauteur = love.graphics.getHeight()
  
    -- compétences du joueur (icones en bas à gauche)
    local skill_1 = myGUI.newButton(0, hauteur - 64, 40, 40,"", mainFont, {151, 220, 250})
        skill_1:setImages(love.graphics.newImage("sprites/hud/health_potion.png"))
        skill_1:setEvent("")
    local buttonParam = myGUI.newButton(largeur -60 , hauteur - 70, 16, 16,"", mainFont, {255, 0, 0})
        buttonParam:setImages(love.graphics.newImage("sprites/hud/gear2.jpg"))
    local skill_2 = myGUI.newButton(65, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
        skill_2:setImages(love.graphics.newImage("sprites/hud/skilll_1.png"))
    local skill_3 = myGUI.newButton(130, hauteur - 65, 40, 40,"", mainFont, {0, 255, 0})
        skill_3:setImages(love.graphics.newImage("sprites/hud/boom.png"))

    --raccourci en vert
    local skillHotkey1 = myGUI.newText(skill_1.W/2 , hauteur - skill_1.H -20, 0, 0,"A", mainFont, "", "", {10, 150, 10})
    -- nombre en doré
    --local skilChargesNum1 = Text:new(skill_1.W -15 , hauteur -23, 0, 0,G_player.potion_stock, mainFont, "", "", {100, 84, 0})
    local skilChargesNum1 = Text:new(skill_1.W -15 , hauteur -23, 0, 0,G_player.potion_stock, mainFont, "", "", {238, 226, 123})

    local skillHotkey2 = myGUI.newText(skill_1.W/2 + skill_2.W , hauteur - skill_1.H -20, 0, 0,"E", mainFont, "", "", {10, 150, 10})

    local skillHotKey3 = myGUI.newText(skill_1.W/2 + skill_2.W*2 , hauteur - skill_1.H -20, 0, 0,"T", mainFont, "", "", {10, 150, 10})


    --inventaire du joueur (icone du milieu pour l'instant)
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


    group:addElement(skill_3)
    
    group:addElement(skill_2)
    group:addElement(skill_1)
    group:addElement(skillHotkey1)
    group:addElement(skillHotkey2)
    group:addElement(skillHotKey3)
    group:addElement(skilChargesNum1, "skillCharges1")


    group:addElement(inventory_slot_1)
    group:addElement(inventory_slot_2)
    group:addElement(inventory_slot_3)
    group:addElement(inventory_slot_4)
    group:addElement(inventory_slot_5)

    group:addElement(buttonParam)

    group:addElement(healthBar, "healthBar")
    group:addElement(healthHeart, "healthHeart")
    print(group)
    return group
end

function Hud:update(dt)
    self.player:update(dt)
end

function Hud:draw()
    self.player:draw()
end

function Hud:updatePotion(pHealth)
    self.player.elements["skillCharges1"]:edit(G_player.potion_stock)
    self.updateHealthPlayer(pHealth)
end

function Hud:updateHealthPlayer(pAmount)
   self.player.elements["healthBar"]:modifyValue(pAmount)
end


-- function Hud:__tostring()
--     for key, value in pairs(self) do
        
--     end
-- end

return Hud
