Hitbox = require("hitbox")

--- Fake class representing Hitbox Patterns
--- @class HitboxPattern
--- @field width number
--- @field height number
--- @field offset Vector

--- Class representing the collection of Hitboxes
--- @class HitboxFactory
--- @field hitboxesPattern table<string, HitboxPattern>
HitboxFactory = {}

--- Constructor of HitboxFactory.
--- @return HitboxFactory
--- @param ... table<string, number, number, Vector>[] Example: {{"hitbox", width, height, offset}, {"hurtbox", width, height, offset}, ...}
function HitboxFactory:new(...)
    local sc = {}
    setmetatable(sc, self)
    self.__index = self

    for i, v in ipairs(...) do
        sc.hitboxesPattern[v.name] = v
    end

    return sc
end

--- Produce an Hitbox from the pattern of the given name at the given position
--- @return Hitbox
function HitboxFactory:produce(pos, name)
    return Hitbox:new(pos, self.hitboxesPattern[name].width, self.hitboxesPattern[name].height, self.hitboxesPattern[name].offset)
end

--- Produce an Hitbox from the pattern of the given name at the given position
--- @return table<string, Hitbox>
function HitboxFactory:produceAll(pos)
    local hitboxes = {}
    for k, v in pairs(self.hitboxesPattern) do
        hitboxes[k] = Hitbox:new(pos, v.width, v.height, v.offset)
    end
    return hitboxes
end

return HitboxFactory