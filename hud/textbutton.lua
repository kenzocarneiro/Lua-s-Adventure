local Text = require("hud/text")

local TextButton = {}


-- Classe fille TextButton qui hérite de Text
function TextButton:new(pX, pY, pW, pH, pText, pFont, pHAlign, pVAlign, pDefaultColor, pSelectedColor, pCoeffX, pCoeffW)
    self.__index = self
    setmetatable(self, {__index = Text}) --heritage

    local notBackground = true

    local myTextButton = Text.new(self, pX, pY, pW, pH, pText, pFont, pHAlign, pVAlign, pDefaultColor, notBackground, pCoeffX, pCoeffW) --appel constructeur de la classe mère
    setmetatable(myTextButton, self)

    -- initialisation
    myTextButton.selected = false
    myTextButton.imgSelected = nil
    myTextButton.imgDefault = nil
    myTextButton.defaultColor = pDefaultColor
    myTextButton.selectedColor = pSelectedColor

    return myTextButton
end

function TextButton:setImages(pImageDefault, pImageSelected, pScale)
    self.imgDefault = pImageDefault
    self.imgSelected = pImageSelected
    self.w = pImageDefault:getWidth()
    self.h = pImageDefault:getHeight()
    self.scale = pScale or 1
end


function TextButton:setSelected(pSelected)
    self.selected = pSelected
end

function TextButton:modifySelected()
    self.selected = not self.selected
    Text.setColor(self, self.selected and self.selectedColor or self.defaultColor)
end

function TextButton:getSelected()
    return self.selected
end


function TextButton:draw()
    if not self.visible then return end
    love.graphics.setColor(1,1,1)
    if self.selected then
        love.graphics.draw(self.imgSelected, self.x, self.y, 0, self.scale)
    else
        love.graphics.draw(self.imgDefault, self.x, self.y, 0, self.scale)
    end
    Text.draw(self)
end

function TextButton:__tostring()
    return "TextButton"
end

return TextButton
