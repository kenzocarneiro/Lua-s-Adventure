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
    local move = Vector:new(0, 0)
    move = move + self.direction
    move = move * self.speed
    self.pos = self.pos + move

    Entity.update(self, dt)
end

function Projectile:draw(draw_hitbox)
    local flipH = 1
    if self.direction.x < 0 then
        flipH = -1
    end
    self.spriteCollection:draw(self.state, self.pos, self.spriteTimer:getCurrentFrame(), flipH)
    if draw_hitbox then
        self.hitboxes["hitbox"]:draw()
    end
end

return Projectile