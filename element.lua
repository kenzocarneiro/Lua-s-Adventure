Vector = require("vector")
Hitbox = require("hitbox")
SpriteTimer = require("sprite/spriteTimer")

--- Class representing elements in the game: anything that is displayed.
--- @class Element
--- @field pos Vector
--- @field health number
--- @field state string
--- @field spriteCollection SpriteCollection
--- @field spriteTimer SpriteTimer
--- @field hitboxes table<string, Hitbox> Example: {["hitbox"] = Hitbox, ["hurtbox"] = Hitbox}
Element = {health = 1, state = "idle"}

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
--- @param hitboxFactory HitboxFactory
function Element:init(pos, spriteCollection, hitboxFactory)
    self.pos = pos or Vector:new(0, 0)

    self.spriteCollection = spriteCollection
    self.spriteTimer = SpriteTimer:new()

    self.hitboxes = hitboxFactory:produceAll(pos)
end

--- Update the element (called every frames).
--- @param dt number
function Element:update(dt)
    if self.spriteCollection:isSpriteSheet(self.state) then
        self.spriteTimer:update(dt, self.spriteCollection:getNumberOfSprites(self.state))
    end
    self.hitboxes["hitbox"]:move(self.pos) -- TODO: move hitbox with element
end

--- Draw the element.
--- @param draw_hitbox boolean
function Element:draw(draw_hitbox)
    self.spriteCollection:draw(self.state, self.pos, self.spriteTimer:getCurrentFrame())
    if draw_hitbox then
        for k, v in pairs(self.hitboxes) do
            v:draw()
        end
    end
end

function Element:changeState(state)
    if self.state ~= state then
        self.state = state
        self.spriteTimer:changeState()
    end
end

function Element:__tostring()
    return "Element"
end

return Element