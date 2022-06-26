local Panel = require("hud/panel")

local KbButton = {}


-- Classe fille Button qui hérite de Panel
function KbButton:new(pX, pY, pW, pH)
    self.__index = self
    setmetatable(self, {__index = Panel}) --heritage

    local myButton = Panel.new(self, pX, pY, pW, pH) --appel constructeur de la classe mère
    setmetatable(myButton, self)

    -- initialisation
    myButton.selected = false
    myButton.imgSelected = nil
    myButton.imgDefault = nil

    return myButton
end

function KbButton:setImages(pImageDefault, pImageSelected, pScale)
    self.imgDefault = pImageDefault
    self.imgSelected = pImageSelected
    self.w = pImageDefault:getWidth()
    self.h = pImageDefault:getHeight()
    self.scale = pScale or 1
end


function KbButton:setSelected(pSelected)
    self.selected = pSelected
end

function KbButton:modifySelected()
    self.selected = not self.selected
end

function KbButton:getSelected()
    return self.selected
end


function KbButton:draw()
    if not self.visible then return end
    love.graphics.setColor(1,1,1)
    if self.selected then
        love.graphics.draw(self.imgSelected, self.x, self.y, 0, self.scale)
    else
        love.graphics.draw(self.imgDefault, self.x, self.y, 0, self.scale)
    end
end

function KbButton:__tostring()
    return "KbButton"
end

return KbButton
