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
    self.loots = ...
end


function LootTable:loot(pos)
    local val = math.random()
    for i, loot in ipairs(self.loots) do
        if val <= loot[1] then
            if loot[2] == "simple_staff" then
                local simple_staff = Weapon:new()
                simple_staff:init(1, "The simple staff", Vector:new(pos.x, pos.y), loot[3], loot[4])
                return simple_staff

            elseif loot[2] == "cool_staff" then
                local cool_staff = Weapon:new()
                cool_staff:init(2, "The cooler staff", Vector:new(pos.x, pos.y), loot[3], loot[4])
                return cool_staff
            elseif loot[2] == "power_staff" then
                local power_staff = Weapon:new()
                power_staff:init(5, "The powerful staff", Vector:new(pos.x, pos.y), loot[3], loot[4])
                return power_staff

            elseif loot[2] == "gold_staff" then
                local gold_staff = Weapon:new()
                gold_staff:init(10, "You achieved capitalism", Vector:new(pos.x, pos.y), loot[3], loot[4])
                return gold_staff
            
            elseif loot[2] == "coin" then
                local goldCoin = Coin:new()
                goldCoin:init(3, "coin of gold", Vector:new(pos.x, pos.y), loot[3])
                return goldCoin

            elseif loot[2] == "healthPotion" then
                local healthPotion = Consumable:new()
                healthPotion:init("health", 1, "potion of health", Vector:new(pos.x, pos.y), loot[3])
                return healthPotion

            elseif loot[2] == "damagePotion" then
                local damagePotion = Consumable:new()
                damagePotion:init("damage", 1, "potion of damage", Vector:new(pos.x, pos.y), loot[3])
                return damagePotion

            elseif loot[2] == "speedPotion" then
                local speedPotion = Consumable:new()
                speedPotion:init("speed", 0.5, "potion of speed", Vector:new(pos.x, pos.y), loot[3])
                return speedPotion
            end
        end
    end
end

return LootTable