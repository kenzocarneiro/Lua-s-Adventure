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
end

--- Update the player (called every frames).
--- @param dt number
function Projectile:update(dt)
    -- convert angle to vector
    local move = self.direction:cpy()
    move = move

    self:move(move)

    Entity.update(self, dt)
end

function Projectile:draw(draw_hitbox)
    self.spriteCollection:draw(self.state, self.pos, self.spriteTimer:getCurrentFrame(), self.direction.x)
    if draw_hitbox then
        self.hitboxes["hitbox"]:draw()
    end
end

function Projectile:__tostring()
    return "Projectile"
end

return Projectile