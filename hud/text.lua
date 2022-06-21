local Panel = require("hud/panel")

local Text = {}


-- Classe fille Text qui hérite de Panel
function Text:new(pX, pY, pW, pH, pText, pFont, pHAlign, pVAlign, pColor)
    self.__index = self
    setmetatable(self, {__index = Panel}) --heritage

    local myText = Panel.new(self, pX, pY, pW, pH) --appel constructeur de la classe mère
    setmetatable(myText, self)
    
    -- initialisation
    myText.text = pText
    myText.font = pFont
    myText.textW = pFont:getWidth(pText)
    myText.textH = pFont:getHeight(pText)
    myText.hAlign = pHAlign
    myText.vAlign = pVAlign
    myText.color = pColor

    return myText
end

function Text:draw()
    if self.visible == false then return end
    self:drawText()
  end

  function Text:drawText()
    love.graphics.setFont(self.font)
    if self.color ~= nil then
      love.graphics.setColor(self.color[1]/255, self.color[2]/255, self.color[3]/255)
    else
      love.graphics.setColor(1,1,1)
    end
    local x = self.x
    local y = self.y
    if self.hAlign == "center" then
      x = x + ((self.w - self.textW) / 2)
    end
    if self.VAlign == "center" then
      y = y + ((self.h - self.textH) / 2)
    end
    love.graphics.print(self.text, x, y)
  end

return Text
