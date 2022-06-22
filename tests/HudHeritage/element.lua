local Element = {}

function Element:new(pX, pY)
    self.__index = self
    local myElement = {}
    setmetatable(myElement, self)

    myElement.X = pX
    myElement.Y = pY
    myElement.Visible = true

    return myElement
end

function Element:draw()
    print("Element draw at " .. self.X .. "," .. self.Y)
end
function Element:update(dt)
    --print("newElement / update / Not implemented")
end
function Element:setVisible(pVisible)
    self.Visible = pVisible
end

return Element
