Hitbox = require("hitbox")

--- Fake class representing Hitbox Patterns with a name
--- @class L_HitboxPattern
--- @field name number
--- @field width number
--- @field height number
--- @field offset Vector

--- Class representing the collection of Hitboxes
--- @class HitboxFactory
--- @field hitboxesPattern table<string, L_HitboxPattern>
HitboxFactory = {}

--- Constructor of HitboxFactory.
--- @return HitboxFactory
--- @param ... L_HitboxPattern[] | (string|number|Vector)[][] Example: HF:new({{"hitbox", width, height, offset}, {name="hurtbox", width=width, height=height, offset=offset}, ...})
function HitboxFactory:new(...)
    local sc = {}
    setmetatable(sc, self)
    self.__index = self

    sc.hitboxesPattern = {}

    for i, v in ipairs{...} do
        if v[1] ~= nil then
            sc.hitboxesPattern[v[1]] =  {name = v[1], width = v[2], height = v[3], offset = v[4]}
        else
            sc.hitboxesPattern[v.name] =  v
        end
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