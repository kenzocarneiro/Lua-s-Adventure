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


    myHud.player = self.setPlayer()
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

    -- barre de vie
    local healthHeart = Panel:new(0, 0)
        healthHeart:setImage(love.graphics.newImage("sprites/hud/health.png"), 0.1)

    local healthBar = Bar:new(35,10, 164, 22, 10, nil,{0,255,0})
  
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
    --local skilChargesNum1 = Text:new(skill_1.w -15 , hauteur -23, 0, 0,G_player.potion_stock, mainFont, "", "", {100, 84, 0})
    local skilChargesNum1 = Text:new(skill_1.w -15 , hauteur -23, 0, 0,G_player.potion_stock, mainFont, "", "", {238, 226, 123})

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

    return group
end

function Hud.setParameter()
    local mainFont = love.graphics.newFont("sprites/hud/kenvector_future_thin.ttf", 15)
    love.graphics.setFont(mainFont)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()
  
    --inventaire du joueur (icone du milieu pour l'instant)
    local offset = screenWidth / 2
    local distanceBetweenInvSlot = 65

    local inventory = Panel:new(screenWidth/2, screenHeight/2, 200, 100)
        inventory:setImage(love.graphics.newImage("sprites/hud/button_white_default.png"), 3)

    local options = Panel:new(screenWidth/2, screenHeight/2 + 50, 200, 100)
        options:setImage(love.graphics.newImage("sprites/hud/button_lightblue_default.png"), 3)


    --parameters du joueur (en bas à droite)
    local buttonParam = Panel:new(screenWidth - 60 , screenHeight - 70, 40, 40)
        buttonParam:setImage(love.graphics.newImage("sprites/hud/gear2.jpg"))
    local paramHotKey = Text:new(buttonParam.x + buttonParam.w/2 , screenHeight - buttonParam.h - 20, 0, 0,"P", mainFont, "", "", {10, 150, 10})

    group:addElement(inventory, "inventory")
    group:addElement(options, "options")


    group:addElement(buttonParam, "buttonParam")
    group:addElement(paramHotKey, "paramHotKey")

    return group
end

function Hud:keypressed(k)
    if k == "m" then
        self.player.elements["healthBar"]:modifyValue(2)
        G_player.currentHealth =G_player.currentHealth + 2
    elseif k == "l" then
        self.player.elements["healthBar"]:modifyValue(-2)
        G_player.currentHealth =G_player.currentHealth - 2
    elseif k == "p" then --button paramtre
        if self.player.visible then
            -- print("\nparam1\n")
            self.player:setVisible(false)
            -- print("\nparam2\n")
            self.parameter:setVisible(true)
        else
            -- print("\nparam2\n")
            self.player:setVisible(true)
            self.parameter:setVisible(false)
        end
    --potion de soin
    elseif k == "a" then
        G_player:ApplyHealthPotionEffect(3)
    elseif k == "m" then
        G_player.currentHealth =G_player.currentHealth - 2
    end
end

function Hud:update(dt)
    for key, value in pairs(self) do
        value:update(dt)
    end
end

function Hud:draw()
    for key, value in pairs(self) do
        value:draw()
    end    
    love.graphics.setColor(1,1,1) --reset color
end

function Hud:updatePotionStock()
    self.player.elements["t_skillCharges1"]:edit(G_player.potion_stock)
    --self.player.elements["healthBar"]:modifyValue(pHealth)
end

function Hud:updateHealthPlayer(pAmount)
    self.player.elements["healthBar"]:modifyValue(pAmount)
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

