Entity = require("entity")

Player = Entity:new()

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