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

    if love.keyboard.isDown("space") then
        print("BOOM")
    end

    if move ~= Vector:new(0, 0) then
        if self.state ~= "attack" then self:changeState("run") end
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
            elseif (not collision_H and not collision_V) and self.hitbox:collide(move, G_hitboxes[i]) and self.hitbox ~= G_hitboxes[i] then
                collision_H = true
                collision_V = true
            end
        end
        if not collision_H then
            self.pos = self.pos + move_H
        end
        if not collision_V then
            self.pos = self.pos + move_V
        end
    else
        if self.state ~= "attack" then self:changeState("idle") end
    end

    local currentFrame, animationFinished = self.spriteTimer:update(dt, self.spriteCollection:getNumberOfSprites(self.state))
    self.hitbox:move(self.pos) -- TODO: move hitbox with element

    -- TODO: Using the sprite frame to define the attack fireRate isn't a good idea.
    if self.state == "attack" and not self.hasShoot and currentFrame == self.spriteCollection:getNumberOfSprites(self.state) - 1 then
        self.hasShoot = true
        local bullet = Bullet:new()
    end
end

function Player:__tostring()
    return "Player"
end

return Player