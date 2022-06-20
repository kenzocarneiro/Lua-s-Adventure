Entity = {x = 0, y = 0, speed = 1, width = 8, height = 8, health = 1}

Hitbox = require("hitbox")

function Entity:new()
    local e = {}
    setmetatable(e, self)
    self.__index = self
    return e
end

function Entity:init(img, isSheet, width, height)
    self.isSheet = isSheet or false

    self.hitbox = Hitbox:new(self.x, self.y, self.width, self.height)


    -- A finir
    if isSheet then
        self.spriteSheet = img
        self.spriteQuads = {}
        for y = 0, img:getHeight() - height, height do
            for x = 0, img:getWidth() - width, width do
                self.spriteQuads[#self.spriteQuads + 1] = love.graphics.newQuad(x, y, width, height, img:getDimensions())
            end
        end
    else
        self.sprite = love.graphics.newImage(img)
    end
end

function Entity:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
    self.hitbox:draw()
end

return Entity