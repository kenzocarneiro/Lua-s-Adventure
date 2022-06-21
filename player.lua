Entity = require("entity")

--- Class representing the Player.
--- @class Player:Entity Player is a subclass of Entity.
Player = Entity:new()
--- Constructor of Player.
--- @return Player
function Player:new() return Entity.new(self) end

--- Update the player (called every frames).
--- @param dt number
function Player:update(dt)
    if love.keyboard.isDown("right", "d") then
        self.pos.x = self.pos.x + self.speed
        self.spriteCollection.flipH = 1
    end
    if love.keyboard.isDown("left", "q") then
        self.pos.x = self.pos.x - self.speed
        self.spriteCollection.flipH = -1
    end
    if love.keyboard.isDown("up", "z") then
        self.pos.y = self.pos.y - self.speed
    end
    if love.keyboard.isDown("down", "s") then
        self.pos.y = self.pos.y + self.speed
    end
    Entity.update(self, dt)
end

return Player