Entity = require("entity/entity")
Item = require("item")

--- Class representing the Monster.
--- @class Monster:Entity Monster is a subclass of Entity.
--- @field chanceOfDrop number
Monster = Entity:new()
--- Constructor of Monster.
--- @return Monster
function Monster:new() return Entity.new(self) end


--- Initializes the monster.
--- @param chanceOfDrop number --between 0 and 1
function Monster:init(chanceOfDrop, ...)
    self.chanceOfDrop = chanceOfDrop or 0

    Entity.init(self, ...)
end


--- Update the monster (called every frames).
--- @param dt number
function Monster:update(dt)
    Entity.update(self, dt)
end

--- To kill the Monster.
--- @return table --the table of Monsters with him deleted
function Monster:die(monsterList)
    for i = 1,#monsterList do
        if monsterList[i] == self then
            table.remove(monsterList, i)
        end
    end
    return monsterList
end


--- The monster drops an item
--- @return Item -- ir nil if doesnt drop
function Monster:drop()
    local item_sc = SpriteCollection:new("item")
    item_sc:init({Sprite:new("img/axe.png", false, "idle", 16, 16, Vector:new(7, 6))})

    local itemHF = HitboxFactory:new({"hitbox", 4, 7, Vector:new(-5, -5)})

    local i = Item:new()
    i:init("AXE !", Vector:new(self.pos.x, self.pos.y), item_sc, itemHF)

    if math.random() <= self.chanceOfDrop then
        return i
    else
        return nil
    end
end

function Monster:__tostring()
    return "Monster"
end

return Monster