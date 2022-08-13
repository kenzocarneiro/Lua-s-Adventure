Item = require("item/item")

--- Class representing Consumable in the game
--- @class Consumable:Item Consumable is a subclass of Item
--- @field new fun(self:Consumable): Consumable
--- @field target string -- target the health or speed for example
--- @field value number  -- the value added/substratcted from the target
Consumable = Item:new()


--- Initializes the Consumable.
--- @param target string -- target the health or speed for example
--- @param value number  -- the value added/substratcted from the target
function Consumable:init(target, value, ...)
    self.target = target or ""
    self.value = value or 0


    Item.init(self, ...)
end

--- Update the Consumable (called every frames).
--- @param dt number
function Consumable:update(dt)
    Item.update(self, dt)
end


function Consumable:__tostring()
    return "Consumable"
end

-- --- Use the Consumable on the player
-- --- @param player Player
-- --- @return table --the {health, speed, damage} table of buffs applied to the player
-- function Consumable:consume(player)
--     if self.target == "health" then
--         return {player.health + self.value, player.speed, 0}
--     elseif self.target == "speed" then
--         return {0, player.speed + self.value, 0}
--     elseif self.target == "damage" then
--         return {0, player.speed, player.damage + self.value}
--     end
-- end

return Consumable