Vector = require("vector")
Hitbox = require("hitbox")
SpriteTimer = require("sprite/spriteTimer")
Timer = require("timer")

--- Class representing elements in the game: anything that is displayed.
--- @class Element
--- @field id number
--- @field pos Vector
--- @field health number
--- @field state string
--- @field spriteCollection SpriteCollection
--- @field spriteTimer SpriteTimer
--- @field hitboxes table<string, Hitbox> Example: {["hitbox"] = Hitbox, ["hurtbox"] = Hitbox}
--- @field flipH number
--- @field flipV number
--- @field angle number
Element = {currentHealth = 1, damage = 1, state = "idle", invulnTime=0.5}

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
--- @param hitboxFactory HitboxFactory|nil
function Element:init(pos, spriteCollection, hitboxFactory, flipH, flipV, angle)
    G_eltCounter = G_eltCounter + 1
    self.id = G_eltCounter

    self.pos = pos or Vector:new(0, 0)

    self.spriteCollection = spriteCollection
    self.spriteTimer = SpriteTimer:new()

    -- test if hitboxFactory is a string
    if hitboxFactory then
        self.hitboxes = hitboxFactory:produceAll(pos, self)
    else
        self.hitboxes = {}
    end

    self.flipH = flipH or 1
    self.flipV = flipV or 1
    self.angle = angle or 0

    self.invulnTimer = Timer:new(self.invulnTime)
    self.invulnAnimTimer = Timer:new()
    self.invulnerable = false

    if self.hitboxes["hitbox"] then G_hitboxes[#G_hitboxes+1] = self.hitboxes["hitbox"] end
    if self.hitboxes["hurtbox"] then G_hurtboxes[#G_hurtboxes+1] = self.hitboxes["hurtbox"] end
end

--- Update the element (called every frames).
--- @param dt number
--- @param scAlreadyUpdated boolean|nil Tells if the spriteCollection of the element was already updated.
function Element:update(dt, scAlreadyUpdated)
    if self.spriteCollection:isSpriteSheet(self.state) and not scAlreadyUpdated then
        self.spriteTimer:update(dt, self.spriteCollection:getSpriteFramesDuration(self.state), self.spriteCollection:getNumberOfSprites(self.state))
    end
    if self.hitboxes["hitbox"] then self.hitboxes["hitbox"]:move(self.pos) end
    if self.hitboxes["hurtbox"] then self.hitboxes["hurtbox"]:move(self.pos) end
    if self.invulnerable then
        self.invulnerable = not self.invulnTimer:update(dt)
        if not self.invulnerable then
            self.invulnAnimTimer:reset()
        end
    end
end

--- Draw the element.
--- @param customState string|nil to set manually which state is drawn
function Element:draw(customState)
    local state = customState or self.state
    self.spriteCollection:draw(state, self.pos, self.spriteTimer:getCurrentFrame(), self.flipH, self.flipV, self.angle)
end

--- Change the Element state and its corresponding sprite
--- @param state string
function Element:changeState(state)
    if self.state ~= state then
        self.state = state
        self.spriteTimer:changeState()
        -- print(self.state)
    end
end

-- Not used anymore, the hurt method is now specific to entities.
-- --- Hurt the Element and check if the Element is dead.
-- --- @param damage number
-- function Element:hurt(damage)
--     if not self.invulnerable then
--         -- print("PAF", self)
--         self.currentHealth = self.currentHealth - damage
--         if self.currentHealth <= 0 then
--             G_deadElements[#G_deadElements + 1] = self
--         end
--         self.invulnerable = true
--     end
-- end

--- Converts the Element to a string.
function Element:__tostring()
    return "Element"
end

return Element