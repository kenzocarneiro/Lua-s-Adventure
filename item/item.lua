Element = require("element")

--- Class representing Items in the game:
--- @class Item:Element Item is a subclass of Entity
--- @field new fun(item: Item): Item
--- @field description string
Item = Element:new()

--- Initializes the item.
--- @param description string
function Item:init(description, ...)
    self.description = description or "item"

    Element.init(self, ...)
    G_itemList[#G_itemList+1] = self
end

--- Update the item (called every frames).
--- @param dt number
function Item:update(dt)
    Element.update(self, dt)
end


function Item:__tostring()
    return "Item"
end

return Item