local Bar = require("hud/bar")
local Button = require("hud/button")
local Checkbox = require("hud/checkbox")
local Group = require("hud/group")
local Panel = require("hud/panel")
local Text = require("hud/text")
local KbButton = require("hud/kbbutton")
local myGUI = require("GCGUI")

local Hud = {}

function Hud:new()
    self.__index = self
    local myHud = {}
    setmetatable(myHud, self)


    myHud.player = self.setPlayer()
    myHud.inventorySlots = self:setInventory()
    
    myHud.parameter = self.setParameter()
        myHud.parameter:setVisible(false)

    return myHud
end

function Hud.setPlayer()
    local mainFont = love.graphics.newFont("sprites/hud/kenvector_future_thin.ttf", 15)
    love.graphics.setFont(mainFont)

    local largeur = love.graphics.getWidth()
    local hauteur = love.graphics.getHeight()

    local group = Group:new()

    -- tests du HUD

    --barre de vie
    local healthHeart = Panel:new(0, 0)
        healthHeart:setImage(love.graphics.newImage("sprites/hud/health.png"), 0.1)
    local healthBar = Bar:new(35,10, 164, 22, G_player.maxHealth, nil,{0,255,0})

    -- barre d'energie
    local energyBar = Bar:new(100, 100, 26, 100, G_player.maxEnergy, nil, {250, 129, 50})
    energyBar:setImages(love.graphics.newImage("sprites/hud/empty_bar.png"),  love.graphics.newImage("sprites/hud/blue_bar.png"),12)



   -- G_button = Button:new(55, 100, 120, 80,"No images", mainFont, {250, 250, 250})
  --  print("g button h :" .. G_button.h)

  -- test bibliothèque
  
    local largeur = love.graphics.getWidth()
    local hauteur = love.graphics.getHeight()
  
    -- compétences du joueur (icones en bas à gauche)
    local skill_1 = Panel:new(0, hauteur - 64, 40, 40)
        skill_1:setImage(love.graphics.newImage("sprites/hud/health_potion.png"))
    local skill_2 = Panel:new(65, hauteur - 64, 40, 40)
        skill_2:setImage(love.graphics.newImage("sprites/hud/skilll_1.png"))
    local skill_3 = Panel:new(130, hauteur - 65, 40, 40)
        skill_3:setImage(love.graphics.newImage("sprites/hud/boom.png"))

    --raccourci en vert
    local skillHotkey1 = Text:new(skill_1.w/2 , hauteur - skill_1.h -20, 0, 0,"A", mainFont, "", "", {10, 150, 10})
    -- nombre en doré
    local skilChargesNum1 = Text:new(skill_1.w -15 , hauteur -23, 0, 0,G_player.potion_stock[G_player.currentPotion], mainFont, "", "", {238, 226, 123})

    local skillHotkey2 = Text:new(skill_1.w/2 + skill_2.w , hauteur - skill_1.h -20, 0, 0,"E", mainFont, "", "", {10, 150, 10})

    local skillHotKey3 = Text:new(skill_1.w/2 + skill_2.w*2 , hauteur - skill_1.h -20, 0, 0,"T", mainFont, "", "", {10, 150, 10})

    --inventaire du joueur (icone du milieu pour l'instant)
    local offset = largeur / 2
    local distanceBetweenInvSlot = 65

    local inventory_slot_1 = Panel:new(offset - distanceBetweenInvSlot * 2, hauteur - 64, 40, 40)
        inventory_slot_1:setImage(love.graphics.newImage("sprites/hud/blank_slot.png"))

    local inventory_slot_2 = Panel:new(offset - distanceBetweenInvSlot, hauteur - 64, 40, 40)
        inventory_slot_2:setImage(love.graphics.newImage("sprites/hud/blank_slot.png"))
    
    local inventory_slot_3 = Panel:new(offset, hauteur - 64, 40, 40)
        inventory_slot_3:setImage(love.graphics.newImage("sprites/hud/blank_slot.png"))
    
    local inventory_slot_4 = Panel:new(offset +distanceBetweenInvSlot, hauteur - 64, 40, 40)
        inventory_slot_4:setImage(love.graphics.newImage("sprites/hud/blank_slot.png"))
    
    local inventory_slot_5 = Panel:new(offset +distanceBetweenInvSlot *2, hauteur - 64, 40, 40)
        inventory_slot_5:setImage(love.graphics.newImage("sprites/hud/blank_slot.png"))

    --parameters du joueur (en bas à droite)
    local buttonParam = Panel:new(largeur - 60 , hauteur - 70, 40, 40)
        buttonParam:setImage(love.graphics.newImage("sprites/hud/gear.png"))
    local paramHotKey = Text:new(buttonParam.x + buttonParam.w/2 , hauteur - buttonParam.h - 20, 0, 0,"P", mainFont, "", "", {10, 150, 10})


    local buff_1 = Panel:new(210,0)
        buff_1:setImage(love.graphics.newImage("sprites/hud/damage_buff.png"), 3)
    local buff_2 = Panel:new(260,0)
        buff_2:setImage(love.graphics.newImage("sprites/hud/speed_buff.png"), 3)

    group:addElement(skill_3, "skill_3")
    group:addElement(skill_2, "skill_2")
    group:addElement(skill_1, "skill_1")

    group:addElement(skilChargesNum1, "t_skillCharges1")
    
    group:addElement(skillHotkey1, "skillHotkey1")
    group:addElement(skillHotkey2, "skillHotkey2")
    group:addElement(skillHotKey3, "skillHotkey3")
    
    group:addElement(inventory_slot_1, "inventory_slot_1")
    group:addElement(inventory_slot_2, "inventory_slot_2")
    group:addElement(inventory_slot_3, "inventory_slot_3")
    group:addElement(inventory_slot_4, "inventory_slot_4")
    group:addElement(inventory_slot_5, "inventory_slot_5")

    group:addElement(buttonParam, "buttonParam")
    group:addElement(paramHotKey, "paramHotKey")

    group:addElement(healthBar, "healthBar")
    group:addElement(healthHeart, "healthHeart")

    group:addElement(buff_1, "buff_1")
    group:addElement(buff_2, "buff_2")

    group:addElement(energyBar, "energyBar")
    return group
end

function Hud:setInventory()

    local inv_group = Group:new()
    local mainFont = love.graphics.newFont("sprites/hud/kenvector_future_thin.ttf", 15)

    local largeur = love.graphics.getWidth()
    local hauteur = love.graphics.getHeight()
  
    --inventaire du joueur (icone du milieu pour l'instant)
    local offset = largeur / 2 + 10
    local distanceBetweenInvSlot = 65

    local img_inventory_slot_1 = Panel:new(offset - distanceBetweenInvSlot * 2, hauteur - 55, 60, 60)
        img_inventory_slot_1:setImage(love.graphics.newImage("sprites/hud/transparent.png"))

    local img_inventory_slot_2 = Panel:new(offset - distanceBetweenInvSlot, hauteur - 55, 60, 60)
        img_inventory_slot_2:setImage(love.graphics.newImage("sprites/hud/transparent.png"))

    local img_inventory_slot_3 = Panel:new(offset, hauteur - 55, 60, 60)
        img_inventory_slot_3:setImage(love.graphics.newImage("sprites/hud/transparent.png"))

    local img_inventory_slot_4 = Panel:new(offset +distanceBetweenInvSlot, hauteur - 55, 60, 60)
        img_inventory_slot_4:setImage(love.graphics.newImage("sprites/hud/transparent.png"))

    local img_inventory_slot_5 = Panel:new(offset +distanceBetweenInvSlot *2, hauteur - 55, 60, 60)
        img_inventory_slot_5:setImage(love.graphics.newImage("sprites/hud/transparent.png"))

    inv_group:addElement(img_inventory_slot_1, "1")
    inv_group:addElement(img_inventory_slot_2, "2")
    inv_group:addElement(img_inventory_slot_3, "3")
    inv_group:addElement(img_inventory_slot_4, "4")
    inv_group:addElement(img_inventory_slot_5, "5")

    return inv_group
end

function Hud.setParameter()
    local mainFontMenu = love.graphics.newFont("sprites/hud/kenvector_future_thin.ttf", 40)
    love.graphics.setFont(mainFontMenu)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()
  
    --inventaire du joueur (icone du milieu pour l'instant)
    local offset = screenWidth / 2
    local distanceBetweenInvSlot = 65

    local inventoryKbButton = KbButton:new(0, screenHeight/2 - 2*7*16) --16px * (zoom+espace) * decalage
        inventoryKbButton:setImages(love.graphics.newImage("sprites/hud/button_white_default.png"), love.graphics.newImage("sprites/hud/button_white_pressed.png"), 6)
        inventoryKbButton.x = screenWidth/2 - 2*inventoryKbButton.w --2*inventory.w pour que le bouton soit centré (*4 pour le zoom et /2 pour le décalage)
        inventoryKbButton:modifySelected()
        local inventoryText = Text:new(inventoryKbButton.x + inventoryKbButton.w/2, inventoryKbButton.y + inventoryKbButton.h/2, 0, 0, "Inventory", mainFontMenu, "", "", {0, 0, 0})

    local optionsKbButton = KbButton:new(inventoryKbButton.x, screenHeight/2 - 1*7*16)
        optionsKbButton:setImages(love.graphics.newImage("sprites/hud/button_lightblue_default.png"), love.graphics.newImage("sprites/hud/button_lightblue_pressed.png"),6)
        local optionsText = Text:new(optionsKbButton.x + optionsKbButton.w/2, optionsKbButton.y + optionsKbButton.h/2, 0, 0, "Options", mainFontMenu, "", "", {0, 0, 0})

    local saveKbButton = KbButton:new(inventoryKbButton.x, screenHeight/2 + 0*7*16)
        saveKbButton:setImages(love.graphics.newImage("sprites/hud/button_blue_default.png"), love.graphics.newImage("sprites/hud/button_blue_pressed.png"),6)
        local saveText = Text:new(saveKbButton.x + saveKbButton.w/2, saveKbButton.y + saveKbButton.h/2, 0, 0, "Save", mainFontMenu, "", "", {0, 0, 0})

    local exitKbButton = KbButton:new(inventoryKbButton.x, screenHeight/2 + 1*7*16)
        exitKbButton:setImages(love.graphics.newImage("sprites/hud/button_darkblue_default.png"), love.graphics.newImage("sprites/hud/button_darkblue_pressed.png"),6)
        local exitText = Text:new(exitKbButton.x + exitKbButton.w/2, exitKbButton.y + exitKbButton.h/2, 0, 0, "Exit", mainFontMenu, "", "", {0, 0, 0})

    --parameters du joueur (en bas à droite)
    local mainFont = love.graphics.newFont("sprites/hud/kenvector_future_thin.ttf", 15)
    love.graphics.setFont(mainFont)
    local buttonParam = Panel:new(screenWidth - 60 , screenHeight - 70, 40, 40)
        buttonParam:setImage(love.graphics.newImage("sprites/hud/gear.png"))
    local paramHotKey = Text:new(buttonParam.x + buttonParam.w/2 , screenHeight - buttonParam.h - 20, 0, 0,"P", mainFont, "", "", {10, 150, 10})

    group:addElement(inventoryKbButton, "inventoryKbButton")
    group:addElement(inventoryText, "inventoryText")

    group:addElement(optionsKbButton, "optionsKbButton")
    group:addElement(optionsText, "optionsText")

    group:addElement(saveKbButton, "saveKbButton")
    group:addElement(saveText, "saveText")

    group:addElement(exitKbButton, "exitKbButton")
    group:addElement(exitText, "exitText")


    group:addElement(buttonParam, "buttonParam")
    group:addElement(paramHotKey, "paramHotKey")

    return group
end

function Hud:keypressed(k)
    if k == "m" then
        G_player.currentHealth =G_player.currentHealth + 5
    elseif k == "l" then
        G_player.currentHealth =G_player.currentHealth - 5
    elseif k == "p" then --button parameter
        if self.parameter.visible then
            self.player:setVisible(true)
            self.inventorySlots:setVisible(true)
            self.parameter:setVisible(false)
        else
            self.player:setVisible(false)
            self.inventorySlots:setVisible(false)
            self.parameter:setVisible(true)
        end
    --potion de soin
    elseif k == "a" then
        G_player:ApplyHealthPotionEffect(20)

    --compétence
    elseif k == "e" then
        G_player:CastSpell()

    end

    if self.parameter.visible then
        self:updateParameter(k)
    end

end

function Hud:update(dt)
    love.graphics.setColor(1,1,1) --reset color
    if G_player.currentPotion == 1 then
        self.player.elements["skill_1"]:setImage(love.graphics.newImage("sprites/hud/health_potion.png"))
    elseif G_player.currentPotion == 2 then
        self.player.elements["skill_1"]:setImage(love.graphics.newImage("sprites/hud/damage_potion.png"))
    elseif G_player.currentPotion == 3 then
        self.player.elements["skill_1"]:setImage(love.graphics.newImage("sprites/hud/speed_potion.png"))
    end


    --update buffs display
    if G_player.buffs[1] ~= 0 then
        self.player.elements["buff_1"]:setImage(love.graphics.newImage("sprites/hud/damage_buff.png"), 3)
    else
        self.player.elements["buff_1"]:setImage(love.graphics.newImage("sprites/hud/transparent.png"), 3)
    end
        
    if G_player.buffs[2] ~= 0 then
        self.player.elements["buff_2"]:setImage(love.graphics.newImage("sprites/hud/speed_buff.png"), 3)
    else
        self.player.elements["buff_2"]:setImage(love.graphics.newImage("sprites/hud/transparent.png"), 3)
    end

    self:updateHealthPlayer(G_player.currentHealth)
    self:updateInventory()
    self:updatePotionStock()

    for key, value in pairs(self) do
        value:update(dt)
    end
end

function Hud:draw()
    for key, value in pairs(self) do
        value:draw()
    end
    love.graphics.setColor(1,1,1)
end

function Hud:updatePotionStock()
    self.player.elements["t_skillCharges1"]:edit(G_player.potion_stock[G_player.currentPotion])
end

function Hud:updateHealthPlayer(pAmount)
    self.player.elements["healthBar"]:setValue(pAmount)
end

function Hud:updateInvSlot(pNumberSlot, pImage)
    self.inventorySlots.elements[tostring(pNumberSlot)]:setImage(pImage)
end

function Hud:updateInventory()
    print(G_player.nextFreeInventorySlotNum)
    if G_player.nextFreeInventorySlotNum > 1 and G_player.nextFreeInventorySlotNum < 5 then
        for i = 1, G_player.nextFreeInventorySlotNum - 1 do
            print(i, "inventaire")
            self.inventorySlots.elements[tostring(i)]:setImage(G_player.inventory[i].spriteCollection.sprites["idle"].loveImg,5)
        end
    end
end

function Hud:updateParameter(k)
    if k == "up" then
        if self.parameter.elements["inventoryKbButton"]:getSelected() then
            self.parameter.elements["inventoryKbButton"]:modifySelected()
            self.parameter.elements["exitKbButton"]:modifySelected()

        elseif self.parameter.elements["optionsKbButton"]:getSelected() then
            self.parameter.elements["optionsKbButton"]:modifySelected()
            self.parameter.elements["inventoryKbButton"]:modifySelected()
        
        elseif self.parameter.elements["saveKbButton"]:getSelected() then
            self.parameter.elements["saveKbButton"]:modifySelected()
            self.parameter.elements["optionsKbButton"]:modifySelected()

        elseif self.parameter.elements["exitKbButton"]:getSelected() then
            self.parameter.elements["exitKbButton"]:modifySelected()
            self.parameter.elements["saveKbButton"]:modifySelected()
        end

    elseif k == "down" then
        if self.parameter.elements["inventoryKbButton"]:getSelected() then
            self.parameter.elements["inventoryKbButton"]:modifySelected()
            self.parameter.elements["optionsKbButton"]:modifySelected()

        elseif self.parameter.elements["optionsKbButton"]:getSelected() then
            self.parameter.elements["optionsKbButton"]:modifySelected()
            self.parameter.elements["saveKbButton"]:modifySelected()
        
        elseif self.parameter.elements["saveKbButton"]:getSelected() then
            self.parameter.elements["saveKbButton"]:modifySelected()
            self.parameter.elements["exitKbButton"]:modifySelected()

        elseif self.parameter.elements["exitKbButton"]:getSelected() then
            self.parameter.elements["exitKbButton"]:modifySelected()
            self.parameter.elements["inventoryKbButton"]:modifySelected()
        end

    elseif k == "return" then
        
    end
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

