Item = require("item/item")

--- Class representing Weapon in the game
--- @class Weapon:Item Weapon is a subclass of Item
--- @field new fun(self:Weapon): Weapon
--- @field value number  -- the value added to the attack
Weapon = Item:new()

--- Initializes the Weapon.
--- @param value number  -- the value added to the attack
function Weapon:init(value, ...)
    self.value = value or 0


    Item.init(self, ...)
end

--- Update the Weapon (called every frames).
--- @param dt number
function Weapon:update(dt)
    Item.update(self, dt)
end


function Weapon:__tostring()
    return "Weapon"
end

return Weapon