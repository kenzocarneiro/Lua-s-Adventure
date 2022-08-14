Entity = require("entity/entity")

--- Class representing a Projectile.
--- @class Projectile:Entity Projectile is a subclass of Entity.
--- @field new fun(self: Projectile): Projectile
Projectile = Entity:new()

--- Initializes the Projectile.
--- @param damage number
--- @param direction Vector|number
---@param speed number
---@param weapon string
---@param pos Vector
---@param spriteCollection SpriteCollection
---@param hitboxFactory HitboxFactory
function Projectile:init(damage, direction, speed, weapon, pos, spriteCollection, hitboxFactory)
    self.damage = damage or 10
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
        ---@diagnostic disable-next-line: param-type-mismatch
        move = G_cylToCart(math.rad(self.direction))
    else
        move = self.direction:cpy()
    end

    self:move(move, dt)

    Entity.update(self, dt)
end

function Projectile:draw()
    if type(self.direction) ~= "number" then
        local flip_H = 1
        if self.direction.x < 0 then flip_H = -1 end
        self.spriteCollection:draw(self.state, self.pos, self.spriteTimer:getCurrentFrame(), flip_H)
    else
        ---@diagnostic disable-next-line: param-type-mismatch
        self.spriteCollection:draw(self.state, self.pos, self.spriteTimer:getCurrentFrame(), 1, 1, self.direction)
    end
end

function Projectile:__tostring()
    return "Projectile"
end

return Projectile