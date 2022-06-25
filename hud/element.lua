local Element = {}


-- classe mère abstraite Element
function Element:new(pX, pY)
    self.__index = self
    local myElement = {}
    setmetatable(myElement, self)
    
    -- initialisation
    myElement.x = pX
    myElement.y = pY
    myElement.visible = true

    return myElement
end

function Element:draw()
    print("Element draw at " .. self.X .. "," .. self.Y)
end
function Element:update(dt)
    --print("newElement / update / Not implemented")
end
function Element:setVisible(pVisible)
    self.visible = pVisible
end

function Element:setPosition(posX, posY)
    self.x = posX
    self.y = posY
end

function Element:__tostring()
    return "Element"
end


return Element