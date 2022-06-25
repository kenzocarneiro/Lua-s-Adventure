--- @class LootTable
--- @field loots table
LootTable = {}



function LootTable:new()
    local l = {}
    setmetatable(l, self)
    self.__index = self

    return l
end

function LootTable:init(...)
    self.loots = {...}
end


function LootTable:loot(pos)
    local val = math.random
    for i, loot in ipairs(self.loots) do
        if val < loot[1] then
            loot[2].pos = pos
            return loot[2]
        end
    end
end

return LootTable