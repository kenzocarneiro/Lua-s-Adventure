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
    G_healthHeart = Panel:new(0, 0)
    G_healthHeart:setImage(love.graphics.newImage("sprites/hud/health.png"), 0.1)
    
    
    --pos x, pos y, largeur, longueur, max, couleur ext, couleur int
    -- healthBar = myGUI.newProgressBar(100,100, 220, 26, 100,    {50,50,50}, {250, 129, 50})

    G_panelTest1 = Panel:new(10, 50)
    G_panelTest1:setImage(love.graphics.newImage("sprites/hud/panel1.png"), 0.1)
    G_title1 = Text:new(G_panelTest1.x + 35, G_panelTest1.y + 45, 0, 0,
    "Shield Generator", mainFont, "", "", {157, 164, 174})
    G_healthBar = Bar:new(10,2, 41, 7, 10, nil,{0,255,0})

   -- G_button = Button:new(55, 100, 120, 80,"No images", mainFont, {250, 250, 250})
  --  print("g button h :" .. G_button.h)

  -- test bibliothèque
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  buttonYes = myGUI.newButton(10, 20, 100, 43,"Yes", mainFont, {151, 220, 250})
  buttonYes:setImages(
    love.graphics.newImage("sprites/hud/button_default.png"),
    love.graphics.newImage("sprites/hud/button_hover.png"),
    love.graphics.newImage("sprites/hud/button_pressed.png")
    )

    buttonParam = myGUI.newButton(largeur - 64, hauteur - 64, 16, 16,"", mainFont, {151, 220, 250})
    buttonParam:setImages(
      love.graphics.newImage("sprites/hud/gear2.jpg")
      )

  buttonNo = myGUI.newButton(115, 20, 100, 43,"No", mainFont, {151, 220, 250})
  buttonNo:setImages(
    love.graphics.newImage("sprites/hud/button_default.png"),
    love.graphics.newImage("sprites/hud/button_hover.png"),
    love.graphics.newImage("sprites/hud/button_pressed.png")
    )
  
  buttonTest3 = myGUI.newButton(55, 100, 120, 80,"No images", mainFont, {250, 250, 250})
  
  panelTest1 = myGUI.newPanel(10, 220, 300, 200)
  panelTest1:setImage(love.graphics.newImage("sprites/hud/panel1.png"))
  panelTest1:setEvent("sprites/hud/hover", onPanelHover)

  panelTest2 = myGUI.newPanel(350, 250)
  panelTest2:setImage(love.graphics.newImage("sprites/hud/panel2.png"))

  textTest = myGUI.newText(panelTest1.X+10, panelTest1.Y,
                           300, 28, "HULL STATUS", mainFont, "", "center", {151, 220, 250})
  
  checkBoxTest1 = myGUI.newCheckbox(250, 30, 24, 24)
  checkBoxTest1:setImages(
    love.graphics.newImage("sprites/hud/dotRed.png"),
    love.graphics.newImage("sprites/hud/dotGreen.png")
  )
  checkBoxTest1:setEvent("pressed", onCheckboxSwitch)
  
  title1 = myGUI.newText(panelTest1.X + 35, panelTest1.Y + 45, 0, 0,
                           "Shield Generator", mainFont, "", "", {157, 164, 174})
  
  progressTest1 = myGUI.newProgressBar(panelTest1.X + 35, panelTest1.Y + 68, 220, 26, 100,
                                      {50,50,50}, {250, 129, 50})
                                    
  progressTest1:setImages(love.graphics.newImage("sprites/hud/progress_grey.png"),
                         love.graphics.newImage("sprites/hud/progress_orange.png"))

  
  title2 = myGUI.newText(panelTest1.X + 35, panelTest1.Y + 45 + 70, 0, 0,
                           "Generator Shield", mainFont, "", "", {157, 164, 174})
  
  progressTest2 = myGUI.newProgressBar(panelTest1.X + 35, panelTest1.Y + 68 + 70, 220, 26, 100,
                                      {50,50,50}, {250, 129, 50})
                                    
  progressTest2:setImages(love.graphics.newImage("sprites/hud/progress_grey.png"),
                         love.graphics.newImage("sprites/hud/progress_green.png"))
                       
  progressTest2:setValue(0)

  groupTest = myGUI.newGroup()
  groupTest:addElement(buttonYes)
  groupTest:addElement(buttonNo)
  groupTest:addElement(buttonTest3)
  groupTest:addElement(panelTest1)
  groupTest:addElement(panelTest2)
  groupTest:addElement(checkBoxTest1)
  groupTest:addElement(textTest)
  groupTest:addElement(title1)
  groupTest:addElement(progressTest1)
  groupTest:addElement(title2)
  groupTest:addElement(progressTest2)
  groupTest:addElement(buttonParam)

G_groupTest = Group:new()
    G_groupTest:addElement(G_panelTest1)
    G_groupTest:addElement(G_healthBar)
    G_groupTest:addElement(G_healthHeart)
  

   -- G_groupTest:addElement(G_button)
    
end

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
   groupTest:update(dt)
end

function love.draw()

  groupTest:draw()

    love.graphics.scale(4, 4)
    G_player:draw()
    G_groupTest:draw()
    

end