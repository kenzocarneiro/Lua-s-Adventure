local Bar = require("hud/bar")
local Button = require("hud/button")
local Checkbox = require("hud/checkbox")
local Group = require("hud/group")
local Panel = require("hud/panel")
local Text = require("hud/text")
local KbButton = require("hud/kbbutton")
local TextButton = require("hud/textbutton")
local myGUI = require("GCGUI")

local textColor = {0, 0, 0}
local textColorSelected = {255, 255, 0}
local textOtherColor = {0, 255, 255}

local Hud = {}

function Hud:new()
    self.__index = self
    local myHud = {}
    setmetatable(myHud, self)

    --main menu
    myHud.mainMenu = self.setMainMenu()

    --game hud
    myHud.player = self.setPlayer()
        myHud.player:setVisible(false)
    myHud.characterSheet = self:setCharacterSheet()

    --options menu
    myHud.optionsMenu = self.setOptions()
        myHud.optionsMenu:setVisible(false)

    --parameter menu
    myHud.parameter = self.setParameter()
        myHud.parameter:setVisible(false)

    --leaderboard menu
    myHud.leader = self.setLeader()
        myHud.leader:setVisible(false)

    --credits menu
    myHud.credits = self.setCredits()
        myHud.credits:setVisible(false)

    --victory menu
    myHud.victory = self.setVictory()
        myHud.victory:setVisible(false)

    --defeat menu
    myHud.defeat = self.setDefeat()
        myHud.defeat:setVisible(false)

    --quest texts
    myHud.questTexts = self.setQuestTexts()
        myHud.questTexts:setVisible(false)

    return myHud

end

-- Create HUD menus

-- texts pour les quêtes, affichages de message d'help, etc.
function Hud.setQuestTexts()
    local mainFontMenu = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 20)
    love.graphics.setFont(mainFontMenu)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()

    --parameters du joueur (en bas à droite)
    local mainFont = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 15)
    love.graphics.setFont(mainFont)

    -- texte temporaire
    local tempText = Text:new(275, 5, 0, 0, "Éliminez tous les monstres pour débloquer l'accès au niveau suivant", mainFontMenu, "", "", {255, 255, 0})
    group:addElement(tempText, "tempText")

    -- texte temporaire
    local level_end = Text:new(275, 5, 0, 0, "Niveau terminé. RENDEZ-vous à l'échelle pour passer à la salle suivante", mainFontMenu, "", "", {0, 225, 0})
    group:addElement(level_end, "level_end")

    -- texte temporaire
    local tuto = Text:new(275, 5, 0, 0, "Déplacez vous dans la pièce avec les touches zqsd", mainFontMenu, "", "", {255, 225, 0})
    group:addElement(tuto, "tuto")

    -- texte temporaire
    local tir = Text:new(325, 5, 0, 0, "Attaquez avec la touche espace", mainFontMenu, "", "", {255, 225, 0})
    group:addElement(tir, "tir")

    -- texte temporaire
    local tutoEnd = Text:new(275, 5, 0, 0, "Empruntez l'échelle de droite pour passer à la salle suivante", mainFontMenu, "", "", {0, 225, 0})
    group:addElement(tutoEnd, "tutoEnd")

    return group
end

function Hud.setMainMenu()
    local mainFontMenu = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 40)
    love.graphics.setFont(mainFontMenu)
    local titleFont = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 50)
    love.graphics.setFont(mainFontMenu)



    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()

    local coeffX, coeffW = 1.06, 6
    local imgZoom = 7

    local titleTextMain = Text:new(0, 20, screenWidth, 0, "Lua's Adventure", titleFont, "center", "", {255, 255, 255})

    local luaShadow =  Panel:new(-300, 100)
    luaShadow:setImage(love.graphics.newImage("img/hud/luaShadow.png"), 0.5)

    local playerFighting =  Panel:new(900, 300)
    playerFighting:setImage(love.graphics.newImage("img/hud/playerFighting.png"), 1)

    local playKbButton = TextButton:new(0, screenHeight/2 - 2*(imgZoom+1)*16 - 15, nil, nil, "Play", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW) --16px * (zoom+espace) * decalage
        playKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"), imgZoom)
        playKbButton.x = screenWidth/2 - 3.5*playKbButton.w --2*inventory.w pour que le bouton soit centré (*4 pour le zoom et /2 pour le décalage)
        playKbButton:modifySelected()
        -- local playText = Text:new(playKbButton.x + playKbButton.w/2, playKbButton.y + playKbButton.h/2, 0, 0, "Play", mainFontMenu, "", "", {0, 0, 0})

    local optionsKbButton = TextButton:new(playKbButton.x, screenHeight/2 - 1*(imgZoom+1)*16 - 15, 0, 0, "Options", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        optionsKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),imgZoom)
        -- local optionsText = Text:new(optionsKbButton.x + optionsKbButton.w/2, optionsKbButton.y + optionsKbButton.h/2, 0, 0, "Options", mainFontMenu, "", "", {0, 0, 0})

    local leaderKbButton = TextButton:new(playKbButton.x, screenHeight/2 + 0*(imgZoom+1)*16 - 15, 0, 0, "LeaderBoard", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
    leaderKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),imgZoom)
        -- local leaderText = Text:new(leaderKbButton.x + leaderKbButton.w/2, leaderKbButton.y + leaderKbButton.h/2, 0, 0, "LeaderBoard", mainFontMenu, "", "", {0, 0, 0})

    local creditsKbButton = TextButton:new(playKbButton.x, screenHeight/2 + 1*(imgZoom+1)*16 - 15, 0, 0, "Credits", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        creditsKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),imgZoom)
        -- local creditsText = Text:new(creditsKbButton.x + creditsKbButton.w/2, creditsKbButton.y + creditsKbButton.h/2, 0, 0, "Credits", mainFontMenu, "", "", {0, 0, 0})

    local exitKbButton = TextButton:new(playKbButton.x, screenHeight/2 + 2*(imgZoom+1)*16 - 15, 0, 0, "Exit", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        exitKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),imgZoom)
        -- local exitText = Text:new(exitKbButton.x + exitKbButton.w/2, exitKbButton.y + exitKbButton.h/2, 0, 0, "Exit", mainFontMenu, "", "", {0, 0, 0})

    --parameters du joueur (en bas à droite)
    local mainFont = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 15)
    love.graphics.setFont(mainFont)
    local buttonParam = Panel:new(screenWidth - 70 , screenHeight - 70, 40, 40)
        buttonParam:setImage(love.graphics.newImage("img/hud/gear.png"))
    local paramHotKey = Text:new(buttonParam.x + buttonParam.w/2 , screenHeight - buttonParam.h - 20, 0, 0,"P", mainFont, "", "", {255, 255, 255})

    group:addElement(luaShadow, "luaShadow")

    group:addElement(playerFighting, "playerFighting")

    group:addElement(titleTextMain, "titleText")

    group:addElement(playKbButton, "playKbButton")
    -- group:addElement(playText, "playText")

    group:addElement(optionsKbButton, "optionsKbButton")
    -- group:addElement(optionsText, "optionsText")

    group:addElement(leaderKbButton, "leaderKbButton")
    -- group:addElement(leaderText, "leaderText")

    group:addElement(creditsKbButton, "creditsKbButton")
    -- group:addElement(creditsText, "creditsText")

    group:addElement(exitKbButton, "exitKbButton")
    -- group:addElement(exitText, "exitText")
    return group
end

function Hud.setPlayer()

    local mainFont = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 17)
    love.graphics.setFont(mainFont)

    local largeur = love.graphics.getWidth()
    local hauteur = love.graphics.getHeight()

    local group = Group:new()

    -- tests du HUD

    --barre de vie
    local healthHeart = Panel:new(0, 0)
        healthHeart:setImage(love.graphics.newImage("img/hud/health.png"), 0.1)
    local healthBar = Panel:new(35,11, 164, 20, {200,30,30})

    local transitionBar = Panel:new(160,11, 0, 20,{200,30,30})

      --barre de vie boss
      local healthHeartBoss = Panel:new(largeur - 700, 0)
      healthHeartBoss:setImage(love.graphics.newImage("img/hud/boss_health.png"), 5)
    local healthBarBoss = Panel:new(largeur - 648,10, 278, 30, {139,0,0})

    local transitionBarBoss = Panel:new(largeur - 648,8, 0, 30,{200,200,30})

    -- barre d'energie
    local energyBarImg = Panel:new(0, 40)
        energyBarImg:setImage(love.graphics.newImage("img/hud/mana.png"), 0.1)
    local energyBar = Panel:new(30,50, 153, 20,{0,0,200})


    local manaCost = Panel:new(170,hauteur - 25)
        manaCost:setImage(love.graphics.newImage("img/hud/mana_ball.png"),2.4)
        local manaCostText = Text:new(176 , hauteur - 19, 0, 0,"10", mainFont, "", "", {200, 0, 0})
        local HealthValueText = Text:new(85 , 11, 0, 0, G_player.currentHealth .. "/" .. G_player.maxHealth, mainFont, "", "", {255, 255, 255})
        local ManaValueText = Text:new(90 , 51, 0, 0, G_player.currentEnergy/100 .. "/" .. G_player.maxEnergy/100, mainFont, "", "", {255, 255, 255})

    local scoreImg =  Panel:new(largeur - 100, 5)
    scoreImg:setImage(love.graphics.newImage("img/hud/Score.png"), 0.65)
    local scoreText = Text:new(largeur - 75, 8, 0, 0, G_player.score.getScore(), mainFont, "", "", {255, 150, 0})

    -- compétences du joueur (icones en bas à gauche)
    local skill_1 = Panel:new(0, hauteur - 64, 40, 40)
        skill_1:setImage(love.graphics.newImage("img/hud/health_potion.png"))
    local skill_2 = Panel:new(65, hauteur - 64, 40, 40)
        skill_2:setImage(love.graphics.newImage("img/hud/skilll_1.png"))
    local skill_3 = Panel:new(130, hauteur - 65, 40, 40)
        skill_3:setImage(love.graphics.newImage("img/hud/boom.png"))

    --raccourci en vert
    local skillHotkey1 = Text:new(skill_1.w/2 , hauteur - skill_1.h -20, 0, 0,"A", mainFont, "", "", {255, 255, 255})
    -- nombre en doré
    local skilChargesNum1 = Text:new(skill_1.w -20 , hauteur -25, 0, 0,G_player.potion_stock[G_player.currentPotion], mainFont, "", "", {255, 255, 255})

    local skillHotkey2 = Text:new(skill_1.w/2 + skill_2.w , hauteur - skill_1.h -20, 0, 0,"", mainFont, "", "", {255, 255, 255})

    local skillHotKey3 = Text:new(skill_1.w/2 + skill_2.w*2 , hauteur - skill_1.h -20, 0, 0,"E", mainFont, "", "", {255, 255, 255})

    --inventaire du joueur (icone du milieu pour l'instant)
    local offset = largeur / 2
    local distanceBetweenInvSlot = 65

    local inventory_slot_1 = Panel:new(offset - distanceBetweenInvSlot * 2, hauteur - 60, 40, 40)
        inventory_slot_1:setImage(love.graphics.newImage("img/hud/itemFrame.png"))

    local inventory_slot_2 = Panel:new(offset - distanceBetweenInvSlot, hauteur - 60, 40, 40)
        inventory_slot_2:setImage(love.graphics.newImage("img/hud/itemFrame.png"))

    local inventory_slot_3 = Panel:new(offset, hauteur - 64, 40, 40)
        inventory_slot_3:setImage(love.graphics.newImage("img/hud/itemFrame.png"))

    local inventory_slot_4 = Panel:new(offset +distanceBetweenInvSlot, hauteur - 64, 40, 40)
        inventory_slot_4:setImage(love.graphics.newImage("img/hud/itemFrame.png"))

    local inventory_slot_5 = Panel:new(offset +distanceBetweenInvSlot *2, hauteur - 64, 40, 40)
        inventory_slot_5:setImage(love.graphics.newImage("img/hud/itemFrame.png"))

    --parameters du joueur (en bas à droite)
    local buttonParam = Panel:new(largeur - 70 , hauteur - 70, 40, 40)
        buttonParam:setImage(love.graphics.newImage("img/hud/gear.png"))
    local paramHotKey = Text:new(buttonParam.x + buttonParam.w/2 , hauteur - buttonParam.h - 20, 0, 0,"P", mainFont, "", "", {255, 255, 255})


    local buff_1 = Panel:new(210,0)
        buff_1:setImage(love.graphics.newImage("img/hud/damage_buff.png"), 3)
    local buff_2 = Panel:new(260,0)
        buff_2:setImage(love.graphics.newImage("img/hud/speed_buff.png"), 3)


    --inventaire du joueur (icone du milieu pour l'instant)
    local offset = largeur / 2 + 10
    local distanceBetweenInvSlot = 65

    local img_inventory_slot_1 = Panel:new(offset - distanceBetweenInvSlot * 2, hauteur - 55, 60, 60)
        img_inventory_slot_1:setImage(love.graphics.newImage("img/hud/transparent.png"))

    local img_inventory_slot_2 = Panel:new(offset - distanceBetweenInvSlot, hauteur - 55, 60, 60)
        img_inventory_slot_2:setImage(love.graphics.newImage("img/hud/transparent.png"))

    local img_inventory_slot_3 = Panel:new(offset, hauteur - 55, 60, 60)
        img_inventory_slot_3:setImage(love.graphics.newImage("img/hud/transparent.png"))

    local img_inventory_slot_4 = Panel:new(offset +distanceBetweenInvSlot, hauteur - 55, 60, 60)
        img_inventory_slot_4:setImage(love.graphics.newImage("img/hud/transparent.png"))

    local img_inventory_slot_5 = Panel:new(offset +distanceBetweenInvSlot *2, hauteur - 55, 60, 60)
        img_inventory_slot_5:setImage(love.graphics.newImage("img/hud/transparent.png"))

    group:addElement(img_inventory_slot_1, "z1")
    group:addElement(img_inventory_slot_2, "z2")
    group:addElement(img_inventory_slot_3, "z3")
    group:addElement(img_inventory_slot_4, "z4")
    group:addElement(img_inventory_slot_5, "z5")

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
    group:addElement(energyBarImg, "energyBarImg")
    group:addElement(manaCost, "zManaCost")
    group:addElement(manaCostText, "zManaCostText")
    group:addElement(HealthValueText, "zHealthValueText")
    group:addElement(ManaValueText, "zEnergyValueText")
    group:addElement(transitionBar, "transitionBar")
    group:addElement(scoreImg, "scoreImg")
    group:addElement(scoreText, "scoreText")


    group:addElement(healthBarBoss, "healthBarBoss")
    group:addElement(healthHeartBoss, "healthHeartBoss")
   -- group:addElement(transitionBarBoss, "transitionBarBoss")

    -- BOSS
    local luaLife = G_bossLife or 0
    local luaMaxLife = G_bossMaxLife or 1
    local bossText = Text:new(largeur - 600, 14, 0, 0, luaLife .. " / " .. luaMaxLife, mainFont, "", "", {255, 255, 255})
    bossText:setVisible(false)
    group:addElement(bossText, "z_bossText")

    return group
end

function Hud.setOptions()
    local mainFontMenu = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 20)
    love.graphics.setFont(mainFontMenu)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()

    local xLeft = screenWidth / 2 - 300
    local xRight = screenWidth / 2 + 100
    local coeffX, coeffW = 1.05, 3
    local imgZoom = 4

    -- G_soundOn = true
    -- G_soundEffectsOn = true
    local soundText = TextButton:new(xLeft, screenHeight/2 - 3*(imgZoom+1)*16, 0, 0, "Sound", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        soundText:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"), imgZoom)
        local soundTextButton = TextButton:new(xRight, soundText.y, nil, nil, "on", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        soundTextButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"), imgZoom)
        soundTextButton:modifySelected()

    local soundEffectsText = TextButton:new(xLeft, screenHeight/2 - 2*(imgZoom+1)*16, 0, 0, "Sound\nEffects", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW, coeffW-1)--car sur 2 lignes
        soundEffectsText:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"), imgZoom)
        local soundEffectsTextButton = TextButton:new(xRight, soundEffectsText.y, nil, nil, "on", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        soundEffectsTextButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"), imgZoom)

    local upText = TextButton:new(xLeft, screenHeight/2 - 1*(imgZoom+1)*16, 0, 0, "Up", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        upText:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"), imgZoom)
        local upTextButton = TextButton:new(xRight, upText.y, nil, nil, "on", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        upTextButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"), imgZoom)


    local menuTextButton = TextButton:new(0, screenHeight/2 + 1*(imgZoom+1)*16, 0, 0, "Menu", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        menuTextButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),imgZoom)
        menuTextButton.x = screenWidth/2 - 3*menuTextButton.w --centré

    group:addElement(soundText, "soundText")
    group:addElement(soundTextButton, "soundTextButton")

    group:addElement(soundEffectsText, "soundEffectsText")
    group:addElement(soundEffectsTextButton, "soundEffectsTextButton")

    group:addElement(upText, "upText")
    group:addElement(upTextButton, "upTextButton")

    group:addElement(menuTextButton, "menuTextButton")

    return group
end

function Hud.setLeader()
    local mainFontMenu = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 40)
    love.graphics.setFont(mainFontMenu)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()

    local upKbButton = KbButton:new(0, screenHeight/2 - 2*7*16) --16px * (zoom+espace) * decalage
        upKbButton:setImages(love.graphics.newImage("img/hud/button_white_default.png"), love.graphics.newImage("img/hud/button_white_pressed.png"), 6)
        upKbButton.x = screenWidth/2 - 3*upKbButton.w --2*inventory.w pour que le bouton soit centré (*4 pour le zoom et /2 pour le décalage)
        upKbButton:modifySelected()
        local upText = Text:new(upKbButton.x + upKbButton.w/2, upKbButton.y + upKbButton.h/2, 0, 0, "Up", mainFontMenu, "", "", {0, 0, 0})

    local menuKbButton = KbButton:new(upKbButton.x, screenHeight/2 + 1*7*16)
        menuKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),6)
        local menuText = Text:new(menuKbButton.x + menuKbButton.w/2, menuKbButton.y + menuKbButton.h/2, 0, 0, "Menu", mainFontMenu, "", "", {0, 0, 0})


    group:addElement(upKbButton, "upKbButton")
    group:addElement(upText, "upText")

    group:addElement(menuKbButton, "menuKbButton")
    group:addElement(menuText, "menuText")


    return group
end

function Hud.setParameter()
    local mainFontMenu = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 40)
    love.graphics.setFont(mainFontMenu)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()

    --inventaire du joueur (icone du milieu pour l'instant)
    local offset = screenWidth / 2
    local distanceBetweenInvSlot = 65

    local coeffX, coeffW = 1.05, 5

    local inventoryKbButton = TextButton:new(0, screenHeight/2 - 2*7*16, 0, 0, "Inventory", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW) --16px * (zoom+espace) * decalage
        inventoryKbButton:setImages(love.graphics.newImage("img/hud/button_white_default.png"), love.graphics.newImage("img/hud/button_white_pressed.png"), 6)
        inventoryKbButton.x = screenWidth/2 - 3*inventoryKbButton.w --2*inventory.w pour que le bouton soit centré (*4 pour le zoom et /2 pour le décalage)
        inventoryKbButton:modifySelected()
        -- local inventoryText = Text:new(inventoryKbButton.x + inventoryKbButton.w/2, inventoryKbButton.y + inventoryKbButton.h/2, 0, 0, "Inventory", mainFontMenu, "", "", {0, 0, 0})

    local optionsKbButton = TextButton:new(inventoryKbButton.x, screenHeight/2 - 1*7*16, 0, 0, "Options", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        optionsKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),6)
        -- local optionsText = Text:new(optionsKbButton.x + optionsKbButton.w/2, optionsKbButton.y + optionsKbButton.h/2, 0, 0, "Options", mainFontMenu, "", "", {0, 0, 0})

    local saveKbButton = TextButton:new(inventoryKbButton.x, screenHeight/2 + 0*7*16, 0, 0, "Save", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        saveKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),6)
        -- local saveText = Text:new(saveKbButton.x + saveKbButton.w/2, saveKbButton.y + saveKbButton.h/2, 0, 0, "Save", mainFontMenu, "", "", {0, 0, 0})

    local menuKbButton = TextButton:new(inventoryKbButton.x, screenHeight/2 + 1*7*16, 0, 0, "Menu", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        menuKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),6)
        -- local menuText = Text:new(menuKbButton.x + menuKbButton.w/2, menuKbButton.y + menuKbButton.h/2, 0, 0, "Menu", mainFontMenu, "", "", {0, 0, 0})

    --parameters du joueur (en bas à droite)
    local mainFont = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 15)
    love.graphics.setFont(mainFont)
    local buttonParam = Panel:new(screenWidth - 70 , screenHeight - 70, 40, 40)
        buttonParam:setImage(love.graphics.newImage("img/hud/gear.png"))
    local paramHotKey = Text:new(buttonParam.x + buttonParam.w/2 , screenHeight - buttonParam.h - 20, 0, 0,"P", mainFont, "", "", {255, 255, 255})

    group:addElement(inventoryKbButton, "inventoryKbButton")
    -- group:addElement(inventoryText, "inventoryText")

    group:addElement(optionsKbButton, "optionsKbButton")
    -- group:addElement(optionsText, "optionsText")

    group:addElement(saveKbButton, "saveKbButton")
    -- group:addElement(saveText, "saveText")

    group:addElement(menuKbButton, "menuKbButton")
    -- group:addElement(menuText, "menuText")


    group:addElement(buttonParam, "buttonParam")
    group:addElement(paramHotKey, "paramHotKey")

    return group
end

function Hud.setCharacterSheet()

    local mainFont = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 15)
    love.graphics.setFont(mainFont)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()

    --inventaire du joueur (icone du milieu pour l'instant)
    local offset = screenWidth / 2
    local distanceBetweenInvSlot = 65
    local imageCharacterSheetLimits = love.graphics.newImage("img/hud/object_box.png")
    local characterSheetLimits = Panel:new(screenWidth / 2 - 0.7*imageCharacterSheetLimits:getWidth() , screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.6)
        characterSheetLimits:setImage(imageCharacterSheetLimits, 1.3)
    group:addElement(characterSheetLimits, "characterSheetLimits")

    local playerNameDesc = Text:new(screenWidth / 2 - 0.21*imageCharacterSheetLimits:getWidth(), screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.45, 0, 0,"player name", mainFont, "", "", {0, 0, 0})
    local playerName = Text:new(screenWidth / 2 - 0.21*imageCharacterSheetLimits:getWidth()+ 15, screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.40, 0, 0,"Gandalf", mainFont, "", "", {215, 55, 0})

    local playerIcon = Panel:new(screenWidth / 2 - 0.42*imageCharacterSheetLimits:getWidth(), screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.45)
        playerIcon:setImage(love.graphics.newImage("img/hud/perso_icon.png"))
    group:addElement(playerNameDesc, "playerNameDesc")
    group:addElement(playerName, "playerName")
    group:addElement(playerIcon, "playerIcon")

    local playerHealthDesc = Text:new(screenWidth / 2 - 0.15*imageCharacterSheetLimits:getWidth(), screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.15, 0, 0," Max Health", mainFont, "", "", {0, 0, 0})
    local playerHealth = Text:new(screenWidth / 2 - 0.1*imageCharacterSheetLimits:getWidth()+ 15, screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.10, 0, 0, tostring(G_player.currentHealth).. " / " ..tostring(G_player.maxHealth), mainFont, "", "", {0, 220, 0})

    local healthIcon = Panel:new(screenWidth / 2 - 0.42*imageCharacterSheetLimits:getWidth(), screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.15)
        healthIcon:setImage(love.graphics.newImage("img/hud/heart_icon.png"))
    group:addElement(playerHealthDesc, "playerHealthDesc")
    group:addElement(playerHealth, "playerHealth")
    group:addElement(healthIcon, "healthIcon")



    local goldDesc = Text:new(screenWidth / 2 - 0.21*imageCharacterSheetLimits:getWidth(), screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.3, 0, 0,"Gold found", mainFont, "", "", {0, 0, 0})
    local goldValue = Text:new(screenWidth / 2 - 0.13*imageCharacterSheetLimits:getWidth()+ 15, screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.25, 0, 0,tostring(G_player.gold), mainFont, "", "", {200, 200, 0})

    local goldIcon = Panel:new(screenWidth / 2 - 0.42*imageCharacterSheetLimits:getWidth(), screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.30)
        goldIcon:setImage(love.graphics.newImage("img/hud/gold_icon.png"))
    group:addElement(goldDesc, "goldDesc")
    group:addElement(goldValue, "goldValue")
    group:addElement(goldIcon, "goldIcon")


    local dmgDesc = Text:new(screenWidth / 2 - 0.21*imageCharacterSheetLimits:getWidth(), screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.01, 0, 0,"Damages dealt", mainFont, "", "", {0, 0, 0})
    local dmgValue = Text:new(screenWidth / 2 - 0.13*imageCharacterSheetLimits:getWidth()+ 15, screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.01 +20 , 0, 0,tostring(G_player.damage), mainFont, "", "", {0, 0, 155})

    local dmgIcon = Panel:new(screenWidth / 2 - 0.42*imageCharacterSheetLimits:getWidth(), screenHeight / 2 - imageCharacterSheetLimits:getHeight() *0.01)
        dmgIcon:setImage(love.graphics.newImage("img/hud/damage_icon.png"))
    group:addElement(dmgDesc, "dmgDesc")
    group:addElement(dmgValue, "dmgValue")
    group:addElement(dmgIcon, "dmgIcon")

    group:setVisible(false)
    return group
end

function Hud.setCredits()
    local mainFontMenu = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 30)
    local titleFont = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 50)
    love.graphics.setFont(mainFontMenu)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()

    local coeffX, coeffW = 1.05, 5

    local imgPanel = Panel:new(0, 0)
        -- imgPanel:setImage(love.graphics.newImage("img/hud/Victory2.png"), 0.8)

    local titleText = Text:new(0, 20, screenWidth, 0, "Lua's Adventure", titleFont, "center", "", {255, 255, 255})
    local devText = Text:new(50, 100, 0, 0, "Developed by:", mainFontMenu, "", "", {255, 255, 255})
    local devName = Text:new(50, 140, 0, 0, "\tLucien Audebert\n\tNicolas Bédrunes\n\tKenzo Carneiro\n\tTristan Claudé\n\tRose Thieullet", mainFontMenu, "", "", textOtherColor)

    local thanksText = Text:new(50, 400, 0, 0, "Special thanks to:", mainFontMenu, "", "", {255, 255, 255})
    local thanksName = Text:new(50, 440, 0, 0, "\tXavier BULTEL\n\tAhmad Abdallah\n\tPascal Berthomé", mainFontMenu, "", "", textOtherColor)

    local assetsText = Text:new(500, 100, 0, 0, "Assets taken from:", mainFontMenu, "", "", {255, 255, 255})
    local assetsName = Text:new(500, 140, 0, 0, "[Sprites]\n\tµFantasy Tileset - 0x72\n\tTiny GUI Pack - vryell\n\tRoguelike/RPG Icons - @JoeCreates\n\tCrown - DK_Happy\n[SFX]\n\tUI 8Bit Retro SOUNDPACK - HoneyPhonic\n\tKenVector Future - Kenney\n\t8-bit Game Sound Effects Collection\n- harvey656\n\tRetro Sounds - Dagurasu\n\t200 Free SFX - Kronbits\n[Musics]\n\tTouhou Project - Team Shanghai Alice", mainFontMenu, "", "", textColorSelected)

    local menuKbButton = TextButton:new(imgPanel.x + 10, screenHeight/2 + 2*7*16, 0, 0, "Menu", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        menuKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),6)
        menuKbButton:modifySelected()
        -- local menuText = Text:new(menuKbButton.x + menuKbButton.w/2, menuKbButton.y + menuKbButton.h/2, 0, 0, "Menu", mainFontMenu, "", "", {0, 0, 0})

    group:addElement(imgPanel, "1imgPanel")

    group:addElement(titleText, "titleText")
    group:addElement(devText, "devText")
    group:addElement(devName, "devName")
    group:addElement(thanksText, "thanksText")
    group:addElement(thanksName, "thanksName")
    group:addElement(assetsText, "assetsText")
    group:addElement(assetsName, "assetsName")

    group:addElement(menuKbButton, "menuKbButton")
    -- group:addElement(menuText, "menuText")

    return group
end

function Hud.setVictory()
    local mainFontMenu = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 40)
    love.graphics.setFont(mainFontMenu)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()

    local coeffX, coeffW = 1.05, 5

    local imgPanel = Panel:new(0, 0)
        imgPanel:setImage(love.graphics.newImage("img/hud/Victory2.png"), 0.87)

    local menuKbButton = TextButton:new(imgPanel.x, screenHeight/2 + 2*7*16, 0, 0, "Menu", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)--16px * (zoom+espace) * decalage
        menuKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),6)
        -- local menuText = Text:new(menuKbButton.x + menuKbButton.w/2, menuKbButton.y + menuKbButton.h/2, 0, 0, "Menu", mainFontMenu, "", "", {0, 0, 0})
        menuKbButton:modifySelected()

    group:addElement(imgPanel, "imgPanel")

    group:addElement(menuKbButton, "menuKbButton")
    -- group:addElement(menuText, "menuText")

    return group
end


function Hud.setDefeat()
    local mainFontMenu = love.graphics.newFont("img/hud/kenvector_future_thin.ttf", 40)
    love.graphics.setFont(mainFontMenu)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local group = Group:new()

    local coeffX, coeffW = 1.05, 5

    local imgPanel = Panel:new(0, 0) --16px * (zoom+espace) * decalage
        imgPanel:setImage(love.graphics.newImage("img/hud/defeat.jpg"), 1.6)

    local menuKbButton = TextButton:new(imgPanel.x, screenHeight/2 + 2*7*16, 0, 0, "Menu", mainFontMenu, "center", "center", textColor, textColorSelected, coeffX, coeffW)
        menuKbButton:setImages(love.graphics.newImage("img/hud/button_blue_default.png"), love.graphics.newImage("img/hud/button_blue_pressed.png"),6)
        -- local menuText = Text:new(menuKbButton.x + menuKbButton.w/2, menuKbButton.y + menuKbButton.h/2, 0, 0, "Menu", mainFontMenu, "", "", {0, 0, 0})
        menuKbButton:modifySelected()

    group:addElement(imgPanel, "imgPanel")

    group:addElement(menuKbButton, "menuKbButton")
    -- group:addElement(menuText, "menuText")

    return group
end

-- Use keypressed to manage the HUD

function Hud:keypressed(k)
    --debug / cheat
    -- if k == "m" and self.player.visible then
    --     self:get_health(30)
    --     if G_soundEffectsOn then
    --         local health=love.audio.newSource("sound/soundeffects/recharge1.wav","static")
    --         health:setVolume(0.2)
    --         health:play()
    --     end
    -- elseif k == "l" and self.player.visible then
    --     self:get_damage(30)
    --     if G_soundEffectsOn then
    --         local damage=love.audio.newSource("sound/soundeffects/fire_hit.wav","static")
    --         damage:setVolume(0.2)
    --         damage:play()
    --     end
    --     G_player.currentHealth =G_player.currentHealth - 5
    -- elseif k == "t" and self.player.visible then
    --     G_player.currentEnergy = G_player.currentEnergy + 1

    --button parameter
    if k == "p" and (self.player.visible or self.parameter.visible) then
        if self.parameter.visible then
            self.player:setVisible(true)
            self.parameter:setVisible(false)
        else
            self.player:setVisible(false)
            self.parameter:setVisible(true)
        end

    --inventory
    elseif k ==  "i" and (self.player.visible or self.characterSheet.visible) then
        self:displayCharacterSheet()
    elseif k == "return" and self.characterSheet.visible then
        self.characterSheet:setVisible(false)
        self.parameter:setVisible(true)
    end

    -- when a menu is displayed
    if k == "return" and (self.victory.visible or self.defeat.visible) then
        G_resetGVariable(0)
    end

    if self.parameter.visible then
        self:keypressedParameter(k)
    elseif self.mainMenu.visible then
        self:keypressedMainMenu(k)
    elseif self.optionsMenu.visible then
        self:keypressedOptions(k)
    elseif k == "return" and (self.leader.visible or self.credits.visible or self.victory.visible or self.defeat.visible) then
        for _, value in pairs(self) do
            value:setVisible(false)
        end
        self.mainMenu:setVisible(true)
    end

end

function Hud:displayCharacterSheet()
    if self.characterSheet.visible then
        self.player:setVisible(true)
        self.characterSheet:setVisible(false)
    else
        self.player:setVisible(false)
        self.characterSheet:setVisible(true)
    end
end

function Hud:keypressedMainMenu(k)
    if k == "up" then
        if G_soundEffectsOn then
            local arrow=love.audio.newSource("sound/soundeffects/select1.wav","static")
            arrow:setVolume(1)
            arrow:play()
        end
        if self.mainMenu.elements["playKbButton"]:getSelected() then
            self.mainMenu.elements["playKbButton"]:modifySelected()
            self.mainMenu.elements["exitKbButton"]:modifySelected()

        elseif self.mainMenu.elements["optionsKbButton"]:getSelected() then
            self.mainMenu.elements["optionsKbButton"]:modifySelected()
            self.mainMenu.elements["playKbButton"]:modifySelected()

        elseif self.mainMenu.elements["leaderKbButton"]:getSelected() then
            self.mainMenu.elements["leaderKbButton"]:modifySelected()
            self.mainMenu.elements["optionsKbButton"]:modifySelected()

        elseif self.mainMenu.elements["creditsKbButton"]:getSelected() then
            self.mainMenu.elements["creditsKbButton"]:modifySelected()
            self.mainMenu.elements["leaderKbButton"]:modifySelected()

        elseif self.mainMenu.elements["exitKbButton"]:getSelected() then
            self.mainMenu.elements["exitKbButton"]:modifySelected()
            self.mainMenu.elements["creditsKbButton"]:modifySelected()
        end

    elseif k == "down" then
        if G_soundEffectsOn then
            local arrow=love.audio.newSource("sound/soundeffects/select1.wav","static")
            arrow:setVolume(1)
            arrow:play()
        end
        if self.mainMenu.elements["playKbButton"]:getSelected() then
            self.mainMenu.elements["playKbButton"]:modifySelected()
            self.mainMenu.elements["optionsKbButton"]:modifySelected()

        elseif self.mainMenu.elements["optionsKbButton"]:getSelected() then
            self.mainMenu.elements["optionsKbButton"]:modifySelected()
            self.mainMenu.elements["leaderKbButton"]:modifySelected()

        elseif self.mainMenu.elements["leaderKbButton"]:getSelected() then
            self.mainMenu.elements["leaderKbButton"]:modifySelected()
            self.mainMenu.elements["creditsKbButton"]:modifySelected()

        elseif self.mainMenu.elements["creditsKbButton"]:getSelected() then
            self.mainMenu.elements["creditsKbButton"]:modifySelected()
            self.mainMenu.elements["exitKbButton"]:modifySelected()

        elseif self.mainMenu.elements["exitKbButton"]:getSelected() then
            self.mainMenu.elements["exitKbButton"]:modifySelected()
            self.mainMenu.elements["playKbButton"]:modifySelected()
        end

    elseif k == "return" then
        if G_soundEffectsOn then
            local arrow=love.audio.newSource("sound/soundeffects/select1.wav","static")
            arrow:setVolume(1)
            arrow:play()
        end
        if self.mainMenu.elements["playKbButton"]:getSelected() then
            self.mainMenu:setVisible(false)
            self.player:setVisible(true)
            self.questTexts.elements["tuto"]:setLifeSpan(4)


        elseif self.mainMenu.elements["optionsKbButton"]:getSelected() then
            self.mainMenu:setVisible(false)
            self.optionsMenu:setVisible(true)

        elseif self.mainMenu.elements["leaderKbButton"]:getSelected() then
            self.mainMenu:setVisible(false)
            self.leader:setVisible(true)

        elseif self.mainMenu.elements["creditsKbButton"]:getSelected() then
            self.mainMenu:setVisible(false)
            self.credits:setVisible(true)

        elseif self.mainMenu.elements["exitKbButton"]:getSelected() then
            love.event.quit()
        end
    end
end

function Hud:keypressedParameter(k)
    if k == "up" then
        if G_soundEffectsOn then
            local arrow=love.audio.newSource("sound/soundeffects/select1.wav","static")
            arrow:setVolume(1)
            arrow:play()
        end
        if self.parameter.elements["inventoryKbButton"]:getSelected() then
            self.parameter.elements["inventoryKbButton"]:modifySelected()
            self.parameter.elements["menuKbButton"]:modifySelected()

        elseif self.parameter.elements["optionsKbButton"]:getSelected() then
            self.parameter.elements["optionsKbButton"]:modifySelected()
            self.parameter.elements["inventoryKbButton"]:modifySelected()

        elseif self.parameter.elements["saveKbButton"]:getSelected() then
            self.parameter.elements["saveKbButton"]:modifySelected()
            self.parameter.elements["optionsKbButton"]:modifySelected()

        elseif self.parameter.elements["menuKbButton"]:getSelected() then
            self.parameter.elements["menuKbButton"]:modifySelected()
            self.parameter.elements["saveKbButton"]:modifySelected()
        end

    elseif k == "down" then
        if G_soundEffectsOn then
            local arrow=love.audio.newSource("sound/soundeffects/select1.wav","static")
            arrow:setVolume(1)
            arrow:play()
        end
        if self.parameter.elements["inventoryKbButton"]:getSelected() then
            self.parameter.elements["inventoryKbButton"]:modifySelected()
            self.parameter.elements["optionsKbButton"]:modifySelected()

        elseif self.parameter.elements["optionsKbButton"]:getSelected() then
            self.parameter.elements["optionsKbButton"]:modifySelected()
            self.parameter.elements["saveKbButton"]:modifySelected()

        elseif self.parameter.elements["saveKbButton"]:getSelected() then
            self.parameter.elements["saveKbButton"]:modifySelected()
            self.parameter.elements["menuKbButton"]:modifySelected()

        elseif self.parameter.elements["menuKbButton"]:getSelected() then
            self.parameter.elements["menuKbButton"]:modifySelected()
            self.parameter.elements["inventoryKbButton"]:modifySelected()
        end

    elseif k == "return" then
        if G_soundEffectsOn then
            local arrow=love.audio.newSource("sound/soundeffects/select1.wav","static")
            arrow:setVolume(1)
            arrow:play()
        end
        if self.parameter.elements["inventoryKbButton"]:getSelected() then
            self.parameter:setVisible(false)
            self.characterSheet:setVisible(true)

        elseif self.parameter.elements["optionsKbButton"]:getSelected() then


        elseif self.parameter.elements["saveKbButton"]:getSelected() then


        elseif self.parameter.elements["menuKbButton"]:getSelected() then
            self.parameter:setVisible(false)
            self.mainMenu:setVisible(true)
        end
    end
end


function Hud:keypressedOptions(k)
    if k == "up" then
        if self.optionsMenu.elements["soundTextButton"]:getSelected() then
            self.optionsMenu.elements["soundTextButton"]:modifySelected()
            self.optionsMenu.elements["menuTextButton"]:modifySelected()

        elseif self.optionsMenu.elements["soundEffectsTextButton"]:getSelected() then
            self.optionsMenu.elements["soundEffectsTextButton"]:modifySelected()
            self.optionsMenu.elements["soundTextButton"]:modifySelected()

        elseif self.optionsMenu.elements["upTextButton"]:getSelected() then
            self.optionsMenu.elements["upTextButton"]:modifySelected()
            self.optionsMenu.elements["soundEffectsTextButton"]:modifySelected()

        elseif self.optionsMenu.elements["menuTextButton"]:getSelected() then
            self.optionsMenu.elements["menuTextButton"]:modifySelected()
            self.optionsMenu.elements["upTextButton"]:modifySelected()
        end

    elseif k == "down" then
        if self.optionsMenu.elements["soundTextButton"]:getSelected() then
            self.optionsMenu.elements["soundTextButton"]:modifySelected()
            self.optionsMenu.elements["soundEffectsTextButton"]:modifySelected()

        elseif self.optionsMenu.elements["soundEffectsTextButton"]:getSelected() then
            self.optionsMenu.elements["soundEffectsTextButton"]:modifySelected()
            self.optionsMenu.elements["upTextButton"]:modifySelected()

        elseif self.optionsMenu.elements["upTextButton"]:getSelected() then
            self.optionsMenu.elements["upTextButton"]:modifySelected()
            self.optionsMenu.elements["menuTextButton"]:modifySelected()

        elseif self.optionsMenu.elements["menuTextButton"]:getSelected() then
            self.optionsMenu.elements["menuTextButton"]:modifySelected()
            self.optionsMenu.elements["soundTextButton"]:modifySelected()
        end

    elseif k == "return" then
        -- G_soundOn = true
        -- G_soundEffectsOn = true
        if self.optionsMenu.elements["soundTextButton"]:getSelected() then
            G_soundOn = not G_soundOn
            self.optionsMenu.elements["soundTextButton"].text = G_soundOn and "On" or "Off"

        elseif self.optionsMenu.elements["soundEffectsTextButton"]:getSelected() then
            G_soundEffectsOn = not G_soundEffectsOn
            self.optionsMenu.elements["soundEffectsTextButton"].text = G_soundEffectsOn and "On" or "Off"

        elseif self.optionsMenu.elements["upTextButton"]:getSelected() then


        elseif self.optionsMenu.elements["menuTextButton"]:getSelected() then
            self.optionsMenu:setVisible(false)
            self.mainMenu:setVisible(true)
        end
    end
end

function Hud:update(dt)
    love.graphics.setColor(1,1,1) --reset color
    if G_player.currentPotion == 1 then
        self.player.elements["skill_1"]:setImage(love.graphics.newImage("img/hud/health_potion.png"))
    elseif G_player.currentPotion == 2 then
        self.player.elements["skill_1"]:setImage(love.graphics.newImage("img/hud/damage_potion.png"))
    elseif G_player.currentPotion == 3 then
        self.player.elements["skill_1"]:setImage(love.graphics.newImage("img/hud/speed_potion.png"))
    end


    --update buffs display
    if G_player.buffs[1] ~= 0 then
        self.player.elements["buff_1"]:setImage(love.graphics.newImage("img/hud/damage_buff.png"), 3)
    else
        self.player.elements["buff_1"]:setImage(love.graphics.newImage("img/hud/transparent.png"), 3)
    end

    if G_player.buffs[2] ~= 0 then
        self.player.elements["buff_2"]:setImage(love.graphics.newImage("img/hud/speed_buff.png"), 3)
    else
        self.player.elements["buff_2"]:setImage(love.graphics.newImage("img/hud/transparent.png"), 3)
    end

    self:updateHealthPlayer()
    self:updateEnergyPlayer()
    self:updateInventory()
    self:updatePotionStock()
    self:updateManaCosts()
    self:updateCharacterSheet()
    self:updateHealthPlayerBetter(1)

    -- BOSS
    local luaLife = G_bossLife or 0
    local luaMaxLife = G_bossMaxLife or 1
    if luaLife ~= 0 then
        self.player.elements["healthBarBoss"]:setWidth((luaLife / luaMaxLife) * 278)
        self.player.elements["healthBarBoss"]:setVisible(true)
        self.player.elements["healthHeartBoss"]:setVisible(true)
        self.player.elements["z_bossText"]:setVisible(true)


    else
        self.player.elements["healthHeartBoss"]:setVisible(false)
        self.player.elements["healthBarBoss"]:setVisible(false)
        self.player.elements["z_bossText"]:setVisible(false)
    end
    self.player.elements["z_bossText"]:edit(luaLife .. " / " .. luaMaxLife)



    for key, value in pairs(self) do
        value:update(dt)
    end
end

function Hud:draw()
    for key, value in pairs(self) do
        value:draw()
    end
   -- love.graphics.arc( "fill", 400, 300, 100, 0, math.rad(G_player.skillAngleCd))
    love.graphics.setColor(1,1,1)
end

function Hud:updateCharacterSheet()
    if self.characterSheet.elements["goldValue"] ~= tostring(G_player.gold) then
        self.characterSheet.elements["goldValue"]:edit(tostring(G_player.gold))
    end

    if self.characterSheet.elements["dmgValue"] ~= tostring(G_player.damage) then
        self.characterSheet.elements["dmgValue"]:edit(tostring(G_player.damage))
    end

    if self.characterSheet.elements["playerHealth"] ~= tostring(G_player.currentHealth).. " / " .. tostring(G_player.maxHealth) then
        self.characterSheet.elements["playerHealth"]:edit(tostring(G_player.currentHealth).. " / " .. tostring(G_player.maxHealth))
    end
end

function Hud:updatePotionStock()
    self.player.elements["t_skillCharges1"]:edit(G_player.potion_stock[G_player.currentPotion])
end

function Hud:updateHealthPlayer()
    self.player.elements["healthBar"]:setWidth((G_player.currentHealth / G_player.maxHealth) * 162)
    self.player.elements["zHealthValueText"]:edit(G_player.currentHealth .. "/" .. G_player.maxHealth)
end
-- 156 : bar length
function Hud:updateEnergyPlayer()
    self.player.elements["energyBar"]:setWidth((G_player.currentEnergy / G_player.maxEnergy) * 151)
    self.player.elements["zEnergyValueText"]:edit(G_player.currentEnergy/100 .. "/" .. G_player.maxEnergy/100)
end

function Hud:updateInvSlot(pNumberSlot, pImage)
    self.player.elements["z"..tostring(pNumberSlot)]:setImage(pImage)
end

function Hud:updateInventory()
    if G_player.nextFreeInventorySlotNum > 1 and G_player.nextFreeInventorySlotNum <= 6 then
        for i = 1, G_player.nextFreeInventorySlotNum - 1 do
            self.player.elements["z"..tostring(i)]:setImage(G_player.inventory[i].spriteCollection.sprites["idle"].loveImg,5)
        end
    end
    if self.player.elements["scoreText"] ~= tostring(G_player.score.getScore()) then
        self.player.elements["scoreText"]:edit(tostring(G_player.score.getScore()))
    end
end

function Hud:updateManaCosts()
    local red = {255,0,0}
    local white = {255, 255, 255}
    -- pas assez de mana pour lancer la compétence
    if G_player.currentEnergy < 9.9 then
    self.player.elements["zManaCostText"]:setColor(red)
    else
        self.player.elements["zManaCostText"]:setColor(white)
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

function Hud:get_damage(amount)
    if G_player.targetHealth > 0 then
        G_player.targetHealth = G_player.targetHealth - amount
    end

    if G_player.targetHealth < 0 then
        G_player.targetHealth = 0
    end
end

function Hud:get_health(amount)
    if G_player.targetHealth < G_player.maxHealth then
        G_player.targetHealth = G_player.targetHealth + amount
    end

    if G_player.targetHealth > G_player.maxHealth then
        G_player.targetHealth = G_player.maxHealth
    end
end

function Hud:updateHealthPlayerBetter(pAmount)

    local healthRatio = G_player.maxHealth / 162
    local healthChangeSpeed = 1
    local transition_width = 0
    local transition_color = {255,0,0}

    -- on a gagné de la vie
    if G_player.currentHealth < G_player.targetHealth then
        G_player.currentHealth = G_player.currentHealth + healthChangeSpeed
        transition_width = tonumber((G_player.targetHealth - G_player.currentHealth) / healthRatio)
        transition_color = {0,255,0}
    end

    -- on a perdu de la vie
    if G_player.currentHealth > G_player.targetHealth then
        G_player.currentHealth = G_player.currentHealth - healthChangeSpeed
        transition_width = tonumber((G_player.targetHealth - G_player.currentHealth) / healthRatio)
        transition_color = {255,255,0}
    end

    local health_bar_width = tonumber(G_player.currentHealth / healthRatio)

    self.player.elements["transitionBar"]:setPosition(self.player.elements["healthBar"].x + self.player.elements["healthBar"].w, self.player.elements["transitionBar"].y)
    self.player.elements["transitionBar"]:setWidth(transition_width)
    self.player.elements["transitionBar"]:setColor(transition_color)


end

return Hud

-- local function onPanelHover(pState)
--   print("Panel is hover:"..pState)
-- end

-- local function onCheckboxSwitch(pState)
--   print("Switch is:"..pState)
-- end
