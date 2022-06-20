Vector = require("vector")
Hitbox = require("hitbox")

Element = {pos = Vector:new(0, 0), health = 1, state = "idle"}

function Element:new()
    local e = {}
    setmetatable(e, self)
    self.__index = self
    return e
end

function Element:init(pos, spriteCollection, hbWidth, hbHeight, hbOffset)
    self.pos = pos or Element.pos

    self.spriteCollection = spriteCollection
    -- self.sprite = love.graphics.newImage(img)
    -- self.isSheet = isSheet or false

    hbWidth = hbWidth or self.width
    hbHeight = hbHeight or self.height
    hbOffset = hbOffset or Vector:new(0, 0)

    self.hitbox = Hitbox:new(self.pos, hbWidth, hbHeight, hbOffset)
end

function Element:update(dt)
    self.spriteCollection:update(dt, self.state)
    self.hitbox:move(self.pos) -- TODO: move hitbox with element
end

function Element:draw(draw_hitbox)
    self.spriteCollection:draw(self.state, false, self.pos)
    if draw_hitbox then
        self.hitbox:draw()
    end
end

return Element