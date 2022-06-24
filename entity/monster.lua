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
function Monster:init(typeOfMove, chanceOfDrop, speed, weapon, pos, spriteCollection, hitboxFactory)
    self.chanceOfDrop = chanceOfDrop or 0
    self.goal = nil
    self.direction = nil
    self.typeOfMove = typeOfMove or "simple"

    Entity.init(self, speed, weapon, pos, spriteCollection, hitboxFactory)
    G_monsterList[#G_monsterList+1] = self
end


--- Update the monster (called every frames).
--- @param dt number
function Monster:update(dt)
    if self.typeOfMove == "simple" then
        self:move(self.goal)
    elseif self.typeOfMove == "advanced" then
        self:betterMove(self.goal)
    else
        self:move(self.goal)
    end

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

    if self.state == "idle" then
        self:changeState("run")
    end

    if move.x < 0 then
        self.flipH = -1
    else
        self.flipH = 1
    end
end

function Monster:betterMove(vect)
    --initialization of the move we want to do
    local move = Vector:new(vect.x-self.pos.x,vect.y-self.pos.y)

    if self.state == "idle" then
        self:changeState("run")
    end

    --if we have a goal
    if self.goal then
        move = move:normalized() * self.speed
        local collision_H, collision_V = Entity.willCollide(self, move)
        if collision_V then
            if move.y > 0 then
                Entity.move(self, Vector:new(-self.speed, 0))
            elseif move.y < 0 then
                Entity.move(self, Vector:new(self.speed, 0))
            end
        end
        if collision_H then
            if move.x > 0 then
                Entity.move(self, Vector:new(0, self.speed))
            elseif move.x < 0 then
                Entity.move(self, Vector:new(0, -self.speed))
            end
        end
        if not collision_V and not collision_H then
            move = Vector:new(vect.x-self.pos.x,vect.y-self.pos.y)
            Entity.move(self, move)
        end
    end

    if move.x < 0 then
        self.flipH = -1
    else
        self.flipH = 1
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