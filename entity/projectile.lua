Entity = require("entity/entity")

--- Class representing a Projectile.
--- @class Projectile:Entity Projectile is a subclass of Entity.
Projectile = Entity:new()
--- Constructor of Projectile.
--- @return Projectile
function Projectile:new() return Entity.new(self) end

function Projectile:init(direction, speed, weapon, pos, spriteCollection, hitboxFactory)
    self.direction = direction

    Entity.init(self, speed, weapon, pos, spriteCollection, hitboxFactory)
    G_projectiles[#G_projectiles+1] = self
end

--- Update the player (called every frames).
--- @param dt number
function Projectile:update(dt)
    -- convert angle to vector
    local move
    if type(self.direction) == "number" then
        -- TODO: INSERT CONVERSION FUNCTION
        -- move = ...
    else
        move = self.direction:cpy()
    end

    self:move(move)

    Entity.update(self, dt)
end

function Projectile:draw()
    if type(self.direction) ~= "number" then
        local flip_H = 1
        if self.direction.x < 0 then flip_H = -1 end
        self.spriteCollection:draw(self.state, self.pos, self.spriteTimer:getCurrentFrame(), flip_H)
    else
        self.spriteCollection:draw(self.state, self.pos, self.spriteTimer:getCurrentFrame(), 1, 1, self.direction)
    end
end

function Projectile:__tostring()
    return "Projectile"
end

return Projectile