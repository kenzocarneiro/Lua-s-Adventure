local Panel = require("hud/panel")
local Text = require("hud/panel")

local Button = {}


-- Classe fille Button qui hérite de Panel
function Button:new(pX, pY, pW, pH, pText, pFont, pColor)
    self.__index = self
    setmetatable(self, {__index = Panel}) --heritage

    local Button = Panel.new(self, pX, pY, pW, pH) --appel constructeur de la classe mère
    setmetatable(Button, self)
    
    -- initialisation
    Button.text = pText
    Button.font = pFont
    Button.label = Text.new(pX, pY, pW, pH, pText, pFont, "center", "center", pColor)
    Button.imgDefault = nil
    Button.imgHover = nil
    Button.imgPressed = nil
    Button.isPressed = false
    Button.oldButtonState = false

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

function GCGUI.newButton
  local myButton = GCGUI.newPanel(pX, pY, pW, pH)
  myButton.Text = pText
  myButton.Font = pFont
  myButton.Label = GCGUI.newText(pX, pY, pW, pH, pText, pFont, "center", "center", pColor)
  myButton.imgDefault = nil
  myButton.imgHover = nil
  myButton.imgPressed = nil
  myButton.isPressed = false
  myButton.oldButtonState = false

  function myButton:setImages(pImageDefault, pImageHover, pImagePressed)
    self.imgDefault = pImageDefault
    self.imgHover = pImageHover
    self.imgPressed = pImagePressed
    self.W = pImageDefault:getWidth()
    self.H = pImageDefault:getHeight()
  end

  function myButton:update(dt)
    self:updatePanel(dt)
    if self.isHover and love.mouse.isDown(1) and
        self.isPressed == false and
        self.oldButtonState == false then
      self.isPressed = true
      if self.lstEvents["pressed"] ~= nil then
        self.lstEvents["pressed"]("begin")
      end
    else
      if self.isPressed == true and love.mouse.isDown(1) == false then
        self.isPressed = false
        if self.lstEvents["pressed"] ~= nil then
          self.lstEvents["pressed"]("end")
        end
      end
    end
    self.oldButtonState = love.mouse.isDown(1)
  end

  function myButton:draw()
    love.graphics.setColor(1,1,1)
    if self.isPressed then
      if self.imgPressed == nil then
        self:drawPanel()
        love.graphics.setColor(1,1,1,.2)
        love.graphics.rectangle("fill", self.X, self.Y, self.W, self.H)
      else
        love.graphics.draw(self.imgPressed, self.X, self.Y)
      end
    elseif self.isHover then
      if self.imgHover == nil then
        self:drawPanel()
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("line", self.X+2, self.Y+2, self.W-4, self.H-4)
      else
        love.graphics.draw(self.imgHover, self.X, self.Y)
      end
    else
      if self.imgDefault == nil then
        self:drawPanel()
      else
        love.graphics.draw(self.imgDefault, self.X, self.Y)
      end    
    end
    self.Label:draw()
  end
  
  return Button
