

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
--- @param pos Vector
--- @param spriteCollection SpriteCollection
--- @param hitboxFactory HitboxFactory
function Entity:init(speed, weapon, pos, spriteCollection, hitboxFactory)
    self.speed = speed or 1
    self.weapon = weapon or "epee"
    self.hasShoot = false
    self.damage = 1

    Element.init(self, pos, spriteCollection, hitboxFactory)
end


--- Test if the entity will collide with another entity if it moves with the move vector
--- @param move Vector
--- @return boolean, boolean
function Entity:willCollide(move)
    local move_H = Vector:new(move.x, 0)
    local move_V = Vector:new(0, move.y)
    local collision_H, collision_V = false, false
    for i, v in pairs(G_hitboxes) do
        if v then
            if self.hitboxes["hitbox"]:collide(v, move_H) and self.hitboxes["hitbox"] ~= v then
                collision_H = true
            end
            if self.hitboxes["hitbox"]:collide(v, move_V) and self.hitboxes["hitbox"] ~= v then
                collision_V = true
            end
        end
    end
    return collision_H, collision_V
end

--- Move the entity (not done yet).
--- @param move Vector
function Entity:move(move)
    move = move:normalized() * self.speed

    local collider = nil

    local move_H = Vector:new(move.x, 0)
    local move_V = Vector:new(0, move.y)
    local collision_H = false
    local collision_V = false
    local hurt = false

    -- for k, v in pairs(G_hitboxes) do
    --     if v then
    --         if self.hitboxes["hitbox"]:collide(move_H, v) and self.hitboxes["hitbox"] ~= v then
    --             collision_H = true
    --             collider = v.associatedElement
    --         end
    --         if self.hitboxes["hitbox"]:collide(move_V, v) and self.hitboxes["hitbox"] ~= v then
    --             collision_V = true
    --             collider = v.associatedElement
    --         end
    --         if collision_H and collision_V then
    --             self.goal = nil
    --             break
    --         end
    --     end
    -- end

    if self.hitboxes["hitbox"] then collision_H, collision_V = self:willCollide(move) end

    local finalMove = Vector:new(0, 0)
    if not collision_H then
        finalMove = finalMove + move_H
    end
    if not collision_V then
        finalMove = finalMove + move_V
    end
    self.pos = self.pos + finalMove

    -- if collision_H or collision_V then
    --     if self.hitboxes["hitbox"].layers["projectileP"] then
    --         G_deadElements[#G_deadElements + 1] = self
    --         if collider ~= -1 then collider:hurt(self.damage) end
    --     end
    -- end

end

--- Update the entity (called every frames).
--- @param dt number
function Entity:update(dt) Element.update(self, dt) end

function Entity:__tostring()
    return "Entity"
end

return Entity