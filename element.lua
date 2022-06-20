Vector = require("vector")
Hitbox = require("hitbox")

--- Class representing elements in the game: anything that is displayed.
--- @class Element
--- @field pos Vector
--- @field health number
--- @field state string
--- @field spriteCollection SpriteCollection
--- @field hitbox Hitbox
Element = {pos = Vector:new(0, 0), health = 1, state = "idle"}

--- Constructor of Element.
--- @return Element
function Element:new()
    local e = {}
    setmetatable(e, self)
    self.__index = self
    return e
end

--- Initializes the element.
--- @param pos Vector
--- @param spriteCollection SpriteCollection
function Element:init(pos, spriteCollection, hbWidth, hbHeight, hbOffset)
    self.pos = pos or Element.pos

    self.spriteCollection = spriteCollection
    -- self.sprite = love.graphics.newImage(img)
    -- self.isSheet = isSheet or false

    hbWidth = hbWidth
    hbHeight = hbHeight
    hbOffset = hbOffset or Vector:new(0, 0)

    self.hitbox = Hitbox:new(self.pos, hbWidth, hbHeight, hbOffset)
end

--- Update the element (called every frames).
--- @param dt number
function Element:update(dt)
    self.spriteCollection:update(dt, self.state)
    self.hitbox:move(self.pos) -- TODO: move hitbox with element
end

--- Draw the element.
--- @param draw_hitbox boolean
function Element:draw(draw_hitbox)
    self.spriteCollection:draw(self.state, false, self.pos)
    if draw_hitbox then
        self.hitbox:draw()
    end
end

return Element