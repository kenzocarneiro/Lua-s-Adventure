Item = require("item")

--- Class representing Consumable in the game
--- @class Wepaon:Item Consumable is a subclass of Item
--- @field value number  -- the value added to the attack
Weapon = Item:new()

--- Constructor of Consumable.
--- @return Wepaon
function Weapon:new() return Item.new(self) end


--- Initializes the Consumable.
--- @param value number  -- the value added to the attack
function Weapon:init(value, ...)
    self.value = value or 0


    Item.init(self, ...)
end

--- Update the Consumable (called every frames).
--- @param dt number
function Weapon:update(dt)
    Item.update(self, dt)
end


function Weapon:__tostring()
    return "Weapon"
end

return Weapon