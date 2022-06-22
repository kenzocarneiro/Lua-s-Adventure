local Panel = require("hud/panel")

local Bar = {}


-- Classe fille Bar qui hérite de Panel
function Bar:new(pX, pY, pW, pH, pMax, pColorOut, pColorIn)
    self.__index = self
    setmetatable(self, {__index = Panel}) --heritage

    local myBar = Panel.new(self, pX, pY, pW, pH) --appel constructeur de la classe mère
    setmetatable(myBar, self)
  
    -- initialisation
    myBar.colorOut = pColorOut
    myBar.colorIn = pColorIn
    myBar.max = pMax
    myBar.value = pMax
    myBar.imgBack = nil
    myBar.imgBar = nil

    return myBar
end

function Bar:setImages(pImageBack, pImageBar)
    self.imgBack = pImageBack
    self.imgBar = pImageBar
    self.w = pImageBack:getWidth()
    self.h = pImageBack:getHeight()
end

function Bar:setValue(pValue)
  if pValue >= 0 and pValue <= self.max then
    self.value = pValue
  else
    print("myProgressBar:setValue error - out of range")
  end
end

function Bar:modifyValue(pValue)

  -- ne peut pas avoir plus de 100% de sa vie
  if self.value + pValue > self.max then
    self.value = self.max

  -- ne peut avoir moins de 0 PV
  elseif self.value + pValue < 0 then
    self.value = 0
  
  -- comportement normal : ajout/retrait de vie
  else
    self.value = self.value + pValue
  end
  
end

function Bar:getValue()
    return self.value
end


function Bar:draw()
  love.graphics.setColor(1,1,1)
  local barSize = (self.w - 2) * (self.value / self.max)
  -- si on a une image pour la barre
  if self.imgBack ~= nil and self.imgBar ~= nil then
    love.graphics.draw(self.imgBack, self.x, self. y)
    local barQuad = love.graphics.newQuad(0, 0, barSize, self.h, self.w, self.h)
    love.graphics.draw(self.imgBar, barQuad, self.x, self. y)

    -- autrement il faut la dessiner
  else
    Panel.draw(self)
    if self.colorOut ~= nil or self.colorIn ~= nil then
      love.graphics.setColor(self.colorIn[1]/255, self.colorIn[2]/255, self.colorIn[3]/255)
    else
      love.graphics.setColor(1,1,1)

    end
    love.graphics.rectangle("fill", self.x + 1, self.y + 1, barSize, self.h - 2)
  end
end

return Bar
