Entity = require("entity")

--- Class representing the Player.
--- @class Player:Entity Player is a subclass of Entity.
Player = Entity:new()
print("[PLAYER]", Player)
--- Constructor of Player.
--- @return Player
function Player:new() return Entity.new(self) end

--- Update the player (called every frames).
--- @param dt number
function Player:update(dt)
    local move = Vector:new(0, 0)
    if love.keyboard.isDown("right", "d") then
        move = Vector:new(self.speed, 0)
        self.spriteCollection.flipH = 1
    end
    if love.keyboard.isDown("left", "q") then
        move = Vector:new(-self.speed, 0)
        self.spriteCollection.flipH = -1
    end
    if love.keyboard.isDown("up", "z") then
        move = Vector:new(0, -self.speed)
    end
    if love.keyboard.isDown("down", "s") then
        move = Vector:new(0, self.speed)
    end

    
    if not self.hitbox:collide(move, hitboxes[2]) then
        self.pos = self.pos + move
    end


    Entity.update(self, dt)
end

function Player:__tostring()
    return "Player"
end

return Player