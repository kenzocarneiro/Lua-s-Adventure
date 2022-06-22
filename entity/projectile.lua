Entity = require("entity/entity")

--- Class representing a Projectile.
--- @class Projectile:Entity Projectile is a subclass of Entity.
Projectile = Entity:new()
--- Constructor of Projectile.
--- @return Projectile
function Projectile:new() return Entity.new(self) end

--- Update the player (called every frames).
--- @param dt number
function Projectile:update(dt)

end

return Projectile