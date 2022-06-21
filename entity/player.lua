Entity = require("entity/entity")

--- Class representing the Player.
--- @class Player:Entity Player is a subclass of Entity.
Player = Entity:new()
--- Constructor of Player.
--- @return Player
function Player:new() return Entity.new(self) end

--- Update the player (called every frames).
--- @param dt number
function Player:update(dt)
    local move = Vector:new(0, 0)
    if love.keyboard.isDown("right", "d") then
        move = move + Vector:new(self.speed, 0)
        self.spriteCollection.flipH = 1
    end
    if love.keyboard.isDown("left", "q") then
        move = move + Vector:new(-self.speed, 0)
        self.spriteCollection.flipH = -1
    end
    if love.keyboard.isDown("up", "z") then
        move = move + Vector:new(0, -self.speed)
    end
    if love.keyboard.isDown("down", "s") then
        move = move + Vector:new(0, self.speed)
    end

    if move ~= Vector:new(0, 0) then
        self:changeState("run")
        local move_H = Vector:new(move.x, 0)
        local move_V = Vector:new(0, move.y)
        local collision_H = false
        local collision_V = false
        for i = 1,#G_hitboxes,1 do
            if self.hitbox:collide(move_H, G_hitboxes[i]) and self.hitbox ~= G_hitboxes[i] then
                collision_H = true
            end
            if self.hitbox:collide(move_V, G_hitboxes[i]) and self.hitbox ~= G_hitboxes[i] then
                collision_V = true
            end
            if collision_H and collision_V then
                break
            -- elseif (not collision_H and not collision_V) and self.hitbox:collide(move, G_hitboxes[i]) and self.hitbox ~= G_hitboxes[i] then
            --     print("BOTH")
            --     collision_H = true
            --     collision_V = true
            end
        end
        print(collision_H, collision_V)
        local finalMove = Vector:new(0, 0)
        if not collision_H then
            finalMove = finalMove + move_H
        end
        if not collision_V then
            finalMove = finalMove + move_V
        end
        self.pos = self.pos + finalMove

    else
        self:changeState("idle")
    end




    Entity.update(self, dt)
end

function Player:__tostring()
    return "Player"
end

return Player