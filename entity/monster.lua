Entity = require("entity/entity")
Item = require("item")
Timer = require("timer")
--IA = require("AI")

--- Class representing the Monster.
--- @class Monster:Entity Monster is a subclass of Entity.
--- @field chanceOfDrop number
Monster = Entity:new()
--- Constructor of Monster.
--- @return Monster
function Monster:new() return Entity.new(self) end


--- Initializes the monster.
--- @param chanceOfDrop number --between 0 and 1
--- @param speed number
--- @param weapon string
--- @param pos Vector
--- @param spriteCollection SpriteCollection
--- @param hitboxFactory HitboxFactory
function Monster:init(chanceOfDrop, speed, weapon, pos, spriteCollection, hitboxFactory)
    self.chanceOfDrop = chanceOfDrop or 0
    self.goal = nil

    Entity.init(self, speed, weapon, pos, spriteCollection, hitboxFactory)
end


--- Update the monster (called every frames).
--- @param dt number
function Monster:update(dt)
    self:move(self.goal)


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

    local itemHF = HitboxFactory:new({"hitbox", {items=true}, 4, 7, Vector:new(-5, -5)})

    local i = Item:new()
    i:init("AXE !", Vector:new(self.pos.x, self.pos.y), item_sc, itemHF)

    if math.random() <= self.chanceOfDrop then
        return i
    else
        return nil
    end
end


function Monster:move(vect)
    --initialization of the move we want to do
    local move = Vector:new(vect.x-self.pos.x,vect.y-self.pos.y)

    --if we have a goal
    if self.goal then
        Entity.move(self, move)
    end
end

-- function Monster:advancedMove(vect, time)
--     if vect == self.pos then
--         self.goal = nil
--     else
--         local path = self.ia:shortestPathFinder(self.pos)

--         local subGoal = path[#path]
--         self:move(subGoal, time)
--     end
-- end


function Monster:__tostring()
    return "Monster"
end

return Monster