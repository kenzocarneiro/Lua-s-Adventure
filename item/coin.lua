Item = require("item/item")

--- Class representing Consumable in the game
--- @class Coin:Item Consumable is a subclass of Item
--- @field new fun(self: Coin): Coin
--- @field value number  -- the value added/substratcted from the target
Coin = Item:new()

--- Initializes the Coin.
--- @param value number  -- the value added/substratcted from the target
function Coin:init(value, ...)
    self.value = value or 0

    Item.init(self, ...)
end

--- Update the Coin (called every frames).
--- @param dt number
function Coin:update(dt)
    Item.update(self, dt)
end


function Coin:__tostring()
    return "Coin"
end

--- Use the Coin
--- @param player Player
--- @return number -- the value of the coin
function Coin:consume(player)
    return self.value
end

return Coin