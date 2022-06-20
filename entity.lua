Entity = {speed=1, weapon="epee", angle=0}

Element = require("element")

Entity = Element:new()

function Entity:init(speed, weapon, ...)
    self.speed = speed or Entity.angle
    self.weapon = weapon or Entity.weapon

    Element:init(...)
end



function Entity:move(dx, dy)
    
end


function Entity:update(dt)
    Element.update(self, dt)
end


return Entity