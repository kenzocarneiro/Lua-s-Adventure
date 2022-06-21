Entity = require("entity/entity")

--- Class representing the Monster.
--- @class Monster:Entity Monster is a subclass of Entity.
Monster = Entity:new()
--- Constructor of Monster.
--- @return Monster
function Monster:new() return Entity.new(self) end

--- Update the monster (called every frames).
--- @param dt number
function Monster:update(dt)
    Entity.update(self, dt)
end

function Monster:__tostring()
    return "Monster"
end

return Monster