Element = require("element")

Player = Element:new()

function Player:update(dt)
    if love.keyboard.isDown("right", "d") then
        self.x = self.x + self.speed
        self.flipH = 1
    end
    if love.keyboard.isDown("left", "q") then
        self.x = self.x - self.speed
        self.flipH = -1
    end
    if love.keyboard.isDown("up", "z") then
        self.y = self.y - self.speed
    end
    if love.keyboard.isDown("down", "s") then
        self.y = self.y + self.speed
    end
    Element.update(self, dt)
end

return Player