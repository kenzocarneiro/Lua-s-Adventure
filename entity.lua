Entity = {x = 0, y = 0, speed = 1, width = 8, height = 8, health = 1, flipH = 1, flipV = 1}

Hitbox = require("hitbox")

function Entity:new()
    local e = {}
    setmetatable(e, self)
    self.__index = self
    return e
end

function Entity:init(x, y, img, isSheet, width, height)
    self.x = x or Entity.x
    self.y = y or Entity.y

    self.sprite = love.graphics.newImage(img)
    self.isSheet = isSheet or false

    self.width = width or Entity.width
    self.height = height or Entity.height

    self.hitbox = Hitbox:new(self.x, self.y, self.width, self.height)

    if isSheet then
        self.frames = {}
        self.currentFrame = 1
        self.frameTimer = 0
        self.interval = 0.1
        for y = 0, self.sprite:getHeight() - height, height do
            for x = 0, self.sprite:getWidth() - width, width do
                self.frames[#self.frames + 1] = love.graphics.newQuad(x, y, width, height, self.sprite:getDimensions())
            end
        end
    end
end

function Entity:update(dt)
    if self.isSheet then
        self.frameTimer = self.frameTimer + dt
        if self.frameTimer > self.interval then
            self.frameTimer = 0
            self.currentFrame = self.currentFrame + 1
            if self.currentFrame > #self.frames then
                self.currentFrame = 1
            end
        end
    end
end

function Entity:draw()
    love.graphics.draw(self.sprite, self.frames[self.currentFrame], self.x, self.y, 0, self.flipH, self.flipV, self.width/2, self.height/2)
    -- self.hitbox:draw()
end

return Entity