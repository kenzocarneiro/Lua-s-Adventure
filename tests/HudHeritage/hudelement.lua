local HUDElement = {}

function HUDElement:new(pX, pY)
    self.__index = self
    local myElement = {}
    setmetatable(myElement, self)

    myElement.X = pX
    myElement.Y = pY
    myElement.Visible = true

    return myElement
end

function HUDElement:draw()
    print("Element draw at " .. self.X .. "," .. self.Y)
end
function HUDElement:update(dt)
    --print("newElement / update / Not implemented")
end
function HUDElement:setVisible(pVisible)
    self.Visible = pVisible
end

return HUDElement
