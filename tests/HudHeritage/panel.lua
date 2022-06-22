local Element = require("element")

local Panel = {}

function Panel:new(pX, pY, pW, pH)
    self.__index = self
    setmetatable(self, {__index = Element}) --heritage

    local myPanel = Element.new(self, pX, pY) --appel constructeur de la classe mère
    setmetatable(myPanel, self)
    
    myPanel.W = pW
    myPanel.H = pH
    
    return myPanel
end

function Panel:draw()
    Element.draw(self)
    print("Panel draw at " .. self.X .. "," .. self.Y)
end

function Panel:add(x)
    self.X = self.X + x
end

return Panel
