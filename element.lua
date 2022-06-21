Vector = require("vector")
Hitbox = require("hitbox")

--- Class representing elements in the game: anything that is displayed.
--- @class Element
--- @field pos Vector
--- @field health number
--- @field state string
--- @field spriteCollection SpriteCollection
--- @field hitbox Hitbox
Element = {health = 1, state = "idle"}
print("[ELEMENT]", Element)

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
    self.pos = pos or Vector:new(0, 0)
    print("[init]", self, self.pos)

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
    print("[update]", self, self.pos)
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

function Element:__tostring()
    return "Element"
end

return Element