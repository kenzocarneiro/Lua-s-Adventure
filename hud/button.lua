local Panel = require("hud/panel")
local Text = require("hud/text")

local Button = {}


-- Classe fille Button qui hérite de Panel
function Button:new(pX, pY, pW, pH, pText, pFont, pColor)
    self.__index = self
    setmetatable(self, {__index = Panel}) --heritage

    local myButton = Panel.new(self, pX, pY, pW, pH) --appel constructeur de la classe mère
    setmetatable(Button, self)
    
    -- initialisation
    Button.text = pText
    Button.font = pFont
    Button.label = Text:new(pX, pY, pW, pH, pText, pFont, "center", "center", pColor)
    Button.imgDefault = nil
    Button.imgHover = nil
    Button.imgPressed = nil
    Button.isPressed = false
    Button.oldButtonState = false

    return myButton
end

function Button:setImages(pImageDefault, pImageHover, pImagePressed)
    self.imgDefault = pImageDefault
    self.imgHover = pImageHover
    self.imgPressed = pImagePressed
    self.w = pImageDefault:getWidth()
    self.h = pImageDefault:getHeight()
end

function Button:update(dt)

    Panel.update(self,dt)
    if self.isHover and love.mouse.isDown(1) and self.isPressed == false and self.oldButtonState == false then
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

function Button:draw()
    love.graphics.setColor(1,1,1)
    if self.isPressed then
        if self.imgPressed == nil then
            Panel.draw(self)
            love.graphics.setColor(1,1,1,.2)
            love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        else
            love.graphics.draw(self.imgPressed, self.x, self.y)
        end
    elseif self.isHover then
        if self.imgHover == nil then
            Panel.draw(self)
            love.graphics.setColor(1,1,1)
            love.graphics.rectangle("line", self.x+2, self.y+2, self.w-4, self.h-4)
        else
            love.graphics.draw(self.imgHover, self.x, self.y)
        end
    else
        if self.imgDefault == nil then
            Panel.draw(self)
        else
            love.graphics.draw(self.imgDefault, self.x, self.y)
        end
    end
    self.label:draw()
end

return Button
