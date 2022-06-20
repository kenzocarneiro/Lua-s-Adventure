Entity = require("entity")

Player = Entity:new()

function Player:update()
    if love.keyboard.isDown("right", "d") then
        self.x = self.x + self.speed
    end
    if love.keyboard.isDown("left", "q") then
        self.x = self.x - self.speed
    end
    if love.keyboard.isDown("up", "z") then
        self.y = self.y - self.speed
    end
    if love.keyboard.isDown("down", "s") then
        self.y = self.y + self.speed
    end
end

return Player