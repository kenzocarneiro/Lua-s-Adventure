local Panel = require("hud/panel")

local Checkbox = {}


-- Classe fille Checkbox qui hérite de Panel
function Checkbox:new(pX, pY, pW, pH)
    self.__index = self
    setmetatable(self, {__index = Panel}) --heritage

    local myCheckbox = Panel.new(self, pX, pY, pW, pH) --appel constructeur de la classe mère
    setmetatable(myCheckbox, self)
    
    -- initialisation
    myCheckbox.imgDefault = nil
    myCheckbox.imgPressed = nil
    myCheckbox.isPressed = false
    myCheckbox.oldButtonState = false

    return myCheckbox
end

function Checkbox:setImages(pImageDefault, pImagePressed)
    self.imgDefault = pImageDefault
    self.imgPressed = pImagePressed
    self.w = pImageDefault:getWidth()
    self.h = pImageDefault:getHeight()
end

function Checkbox:setState(pbState)
    self.isPressed = pbState
end

function Checkbox:update(dt)
    Panel.update(self, dt)
    if self.isHover and love.mouse.isDown(1) and self.isPressed == false and self.oldButtonState == false then
        self.isPressed = true
        if self.lstEvents["pressed"] ~= nil then
            self.lstEvents["pressed"]("on")
        end
    elseif self.isHover and love.mouse.isDown(1) and self.isPressed == true and self.oldButtonState == false then
        self.isPressed = false
        if self.lstEvents["pressed"] ~= nil then
            self.lstEvents["pressed"]("off")
        end
    end
    self.oldButtonState = love.mouse.isDown(1)
end

function Checkbox:draw()
    if not self.visible then return end
    love.graphics.setColor(1,1,1)
    if self.isPressed then
        if self.imgPressed == nil then
            Panel.draw(self)
            love.graphics.setColor(1,1,1,.2)
            love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        else
            love.graphics.draw(self.imgPressed, self.x, self.y)
        end
    else
        if self.imgDefault == nil then
            Panel.draw(self)
        else
            love.graphics.draw(self.imgDefault, self.x, self.y)
        end
    end
end

return Checkbox
