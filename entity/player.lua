Entity = require("entity/entity")
Projectile = require("entity/projectile")

--- Class representing the Player.
--- @class Player:Entity Player is a subclass of Entity.
--- @field inventory table
--- @field collectRadius number
Player = Entity:new()
--- Constructor of Player.
--- @return Player
function Player:new() return Entity.new(self) end

--- Initializes the item.
--- @param inventory table
--- @param collectRadius number
function Player:init(inventory, collectRadius, ...)
    self.inventory = inventory or {}
    self.collectRadius = collectRadius or 10
    self.radiusDisplay = false
    self.gold = 0

    Entity.init(self, ...)
end

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

    --moving and verifying collision
    if move ~= Vector:new(0, 0) then
        if self.state ~= "attack" then self:changeState("run") end
        local move_H = Vector:new(move.x, 0)
        local move_V = Vector:new(0, move.y)
        local collision_H = false
        local collision_V = false
        for i = 1,#G_hitboxes do
            if G_hitboxes[i] then
                if self.hitbox:collide(move_H, G_hitboxes[i]) and self.hitbox ~= G_hitboxes[i] then
                    collision_H = true
                end
                if self.hitbox:collide(move_V, G_hitboxes[i]) and self.hitbox ~= G_hitboxes[i] then
                    collision_V = true
                end
                if collision_H and collision_V then
                    break
                end
            end
        end

        local finalMove = Vector:new(0, 0)
        if not collision_H then
            finalMove = finalMove + move_H
        end
        if not collision_V then
            finalMove = finalMove + move_V
        end
        self.pos = self.pos + finalMove

    else
        if self.state ~= "attack" then self:changeState("idle") end
    end

    local currentFrame, animationFinished = self.spriteTimer:update(dt, self.spriteCollection:getNumberOfSprites(self.state))
    self.hitbox:move(self.pos) -- TODO: move hitbox with element

    -- TODO: Using the sprite frame to define the attack fireRate isn't a good idea.
    if self.state == "attack" and currentFrame == self.spriteCollection:getNumberOfSprites(self.state) - 1 then
        self.hasShoot = true
        local p = Projectile:new()
        local direction = Vector:new(self.spriteCollection.flipH, 0)

        if self.spriteCollection.flipH == 1 then
            p:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, 3, 3, Vector:new(-2, -2))
        elseif self.spriteCollection.flipH == -1 then
            p:init(direction, 5, "bullet", self.pos + Vector:new(-9, 5), G_fireballSC, 3, 3, Vector:new(-1, -2))
        end

        G_projectiles[#G_projectiles+1] = p
        G_hitboxes[#G_hitboxes+1] = p.hitbox
        self.state = "idle"
    end
end

--- Draw the Player.
--- @param draw_hitbox boolean
function Player:draw(draw_hitbox)

    if self.radiusDisplay then
        love.graphics.setLineWidth(0.3)
        love.graphics.circle("line", self.pos.x, self.pos.y, self.collectRadius)
    end

    Entity.draw(self, draw_hitbox)
end


--- allow the Player to pickup items
--- @param item Item
--- @return boolean --true if we pickup the item, false if we cant
function Player:pickup(item)
    local itemX = item.pos.x
    local itemY = item.pos.y

    if ((itemX-self.pos.x)^2 + (itemY - self.pos.y)^2) <= (self.collectRadius^2) then
        self.inventory[#self.inventory+1] = item
        return true
    end
    return false
end

function Player:__tostring()
    return "Player"
end

return Player