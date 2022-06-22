-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

-- Pour notre magnifique HUD
local Group = require("hud/group")
local Panel = require("hud/panel")
local Bar = require("hud/bar")
local Text = require("hud/text")

local myGUI = require("GCGUI")
function onPanelHover(pState)
    print("Panel is hover:"..pState)
  end
  
  function onCheckboxSwitch(pState)
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

    -- test perso
    -- tests du HUD
    G_healthHeart = Panel:new(0, 0)
    G_healthHeart:setImage(love.graphics.newImage("sprites/hud/health.png"), 0.1)

    G_healthBar = Bar:new(10,2, 41, 7, 10, nil,{0,255,0})

   -- G_button = Button:new(55, 100, 120, 80,"No images", mainFont, {250, 250, 250})
  --  print("g button h :" .. G_button.h)

  -- test bibliothèque
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  skill_1 = myGUI.newButton(0, hauteur - 64, 40, 40,"", mainFont, {151, 220, 250})
  skill_1:setImages(
    love.graphics.newImage("sprites/hud/health_potion.png")
   
    )
    skill_1:setEvent("")

    buttonParam = myGUI.newButton(largeur -60 , hauteur - 70, 16, 16,"", mainFont, {255, 0, 0})
    buttonParam:setImages(
      love.graphics.newImage("sprites/hud/gear2.jpg")
   

      )

  skill_2 = myGUI.newButton(65, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
  skill_2:setImages(
    love.graphics.newImage("sprites/hud/skilll_1.png")
    )

    skill_3 = myGUI.newButton(130, hauteur - 65, 40, 40,"", mainFont, {0, 255, 0})
  skill_3:setImages(
    love.graphics.newImage("sprites/hud/boom.png")
    )
  
    offset = largeur / 2
    distanceBetweenInvSlot = 65

    inventory_slot_1 = myGUI.newButton(offset - distanceBetweenInvSlot * 2, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
    inventory_slot_1:setImages(
    love.graphics.newImage("sprites/hud/blank_slot.png")
    )
    inventory_slot_2 = myGUI.newButton(offset - distanceBetweenInvSlot, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
    inventory_slot_2:setImages(
    love.graphics.newImage("sprites/hud/blank_slot.png")
    )
    inventory_slot_3 = myGUI.newButton(offset, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
    inventory_slot_3:setImages(
    love.graphics.newImage("sprites/hud/blank_slot.png")
    )
    inventory_slot_4 = myGUI.newButton(offset +distanceBetweenInvSlot, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
  inventory_slot_4:setImages(
    love.graphics.newImage("sprites/hud/blank_slot.png")
    )
    inventory_slot_5 = myGUI.newButton(offset +distanceBetweenInvSlot *2, hauteur - 64, 40, 40,"", mainFont, {0, 255, 0})
    inventory_slot_5:setImages(
      love.graphics.newImage("sprites/hud/blank_slot.png")
      )

      title1 = myGUI.newText(skill_1.W/2 , hauteur - skill_1.H -20, 0, 0,
                           "A", mainFont, "", "", {25, 150, 25})
  
      title2 = myGUI.newText(skill_1.W/2 + skill_2.W , hauteur - skill_1.H -20, 0, 0,
      "E", mainFont, "", "", {25, 150, 25})

      title3 = myGUI.newText(skill_1.W/2 + skill_2.W*2 , hauteur - skill_1.H -20, 0, 0,
      "T", mainFont, "", "", {25, 150, 25})
  
    
  G_groupTest = myGUI.newGroup()
  
  G_groupTest:addElement(skill_3)
  
  G_groupTest:addElement(skill_2)
  G_groupTest:addElement(skill_1)
  G_groupTest:addElement(title1)
  G_groupTest:addElement(title2)
  G_groupTest:addElement(title3)

  G_groupTest:addElement(inventory_slot_1)
  G_groupTest:addElement(inventory_slot_2)
  G_groupTest:addElement(inventory_slot_3)
  G_groupTest:addElement(inventory_slot_4)
  G_groupTest:addElement(inventory_slot_5)

  G_groupTest:addElement(buttonParam)

    G_health = Group:new()
    G_health:addElement(G_healthBar)
    G_health:addElement(G_healthHeart)

   

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
    G_health:draw()
    G_player:draw()

end
