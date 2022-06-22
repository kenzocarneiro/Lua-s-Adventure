

Element = require("element")

--- Class representing entities in the game: anything that is alive.
--- @class Entity:Element Entity is a subclass of Element
--- @field speed number
--- @field weapon number
Entity = Element:new()
--- Constructor of Entity.
--- @return Entity
function Entity:new() return Element.new(self) end


--- Initializes the entity.
--- @param speed number
--- @param weapon string
function Entity:init(speed, weapon, ...)
    self.speed = speed or 1
    self.weapon = weapon or "epee"
    self.hasShoot = false

    Element.init(self, ...)
end

--- Move the entity (not done yet).
--- @param dx number
--- @param dy number
function Entity:move(dx, dy) end

--- Update the entity (called every frames).
--- @param dt number
function Entity:update(dt) Element.update(self, dt) end

function Entity:__tostring()
    return "Entity"
end

return Entity