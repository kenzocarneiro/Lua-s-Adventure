local Panel = require("hud/panel")

local Text = {}


-- Classe fille Text qui hérite de Panel
function Text:new(pX, pY, pW, pH, pText, pFont, pHAlign, pVAlign, pColor, pNotBackground, pCoeffX, pCoeffW, pCoeffH)
    self.__index = self
    setmetatable(self, {__index = Panel}) --heritage

    local myText = Panel.new(self, pX, pY, pW, pH, nil, pNotBackground) --appel constructeur de la classe mère
    setmetatable(myText, self)
    
    -- initialisation
    myText.text = pText
    myText.font = pFont
    myText.textW = pFont:getWidth(pText)
    myText.textH = pFont:getHeight(pText)
    myText.hAlign = pHAlign
    myText.vAlign = pVAlign
    myText.coeffX = pCoeffX or 1
    myText.coeffW = pCoeffW or 1
    myText.coeffH = pCoeffH or pCoeffW or 1
    myText.color = pColor
    myText.speedTimer = nil
    -- si lifespan est négatif, il est permanent, sinon il est temporaire
    myText.lifeSpan = nil
    myText.timer = nil
    myText.movementNb = 0
    myText.enabled = true
    myText.forceOff = false
    return myText
end

function Text:setVelocity(pSpeed)
  self.speedTimer = Timer:new(pSpeed)
end

function Text:reset()
  self.enabled = true
end

function Text:setLifeSpan(pLifeSpan)
  if self.enabled then
    self.lifeSpan = Timer:new(pLifeSpan)
    self:setVisible(true)
    self.enabled = false
  end
end

-- pour les textes temporaires et / ou flottants
function Text:update(dt)
    if self.lifeSpan and self.lifeSpan:update(dt) then
        self.lifeSpan = nil
        self:setVisible(false)
    
      if self.text == "Déplacez vous dans la pièce avec les touches zqsd" then
          G_hud.questTexts.elements["tir"]:setLifeSpan(4)
          if self.forceOff then
            G_hud.questTexts.elements["tir"]:setVisible(false)
          end

      elseif self.text == "Attaquez avec la touche espace" then
        G_hud.questTexts.elements["tutoEnd"]:setLifeSpan(4)
        if self.forceOff then
          G_hud.questTexts.elements["tutoEnd"]:setVisible(false)
        end
      end
    end
end

function Text:posUpdate(dt)
  if self.speedTimer and self.speedTimer:update(dt) then
    if self.movementNb < 20 then
      self.speedTimer = nil
      self.posUpdate(self.x, self.y - 1)
      self.movementNb = self.movementNb + 1
      self.speedTimer = Timer:new(0.2)
    elseif self.movementNb > 20 then
      self.speedTimer = nil
    end
  end
end



function Text:draw()
    if not self.visible then return end

  
    Panel.draw(self)
    love.graphics.setFont(self.font)
    if self.color ~= nil then
        love.graphics.setColor(self.color[1]/255, self.color[2]/255, self.color[3]/255)
    else
        love.graphics.setColor(1,1,1)
    end
    local x = self.x
    local y = self.y
    if self.hAlign == "center" then
        x = self.coeffX*x + ((self.w*self.coeffW - self.textW) / 2)
    end
    if self.vAlign == "center" then
        y = y + ((self.h*self.coeffH - self.textH) / 2)
    end
    -- print(self.x .. " " .. x .. " " .. self.w .. " " .. self.textW)
    love.graphics.print(self.text, x, y)
  end

  function Text:setText(pString)
    self.text =pString
  end

  function Text:edit(pString) --old function (retrocompatility)
    self:setText(pString)
  end
  
  function Text:setColor(pColor)
    self.color = pColor
  end
return Text
