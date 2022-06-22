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
function Monster:init(chanceOfDrop, ...)
    self.chanceOfDrop = chanceOfDrop or 0
    self.goal = nil
    self.speed = 0.03
    self.timer = Timer:new(self.speed)
    --self.ia = IA:new(G_room)

    Entity.init(self, ...)
end


--- Update the monster (called every frames).
--- @param dt number
function Monster:update(dt)
    local time = self.timer:update(dt)
    self:move(self.goal, time)


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


function Monster:move(vect, time)
    --initialization of the move we want to do
    local move = Vector:new(vect.x-self.pos.x,vect.y-self.pos.y)

    --reduction of the values to the speed
    if math.abs(move.x) > self.speed then
        if move.x < 0 then
            move.x = -self.speed
        else
            move.x = self.speed
        end
    end
    if math.abs(move.y) > self.speed then
        if move.y < 0 then
            move.y = -self.speed
        else
            move.y = self.speed
        end
    end

    --if we have goal and if the timer is finished we try to move
    if self.goal and time then

        local move_H = Vector:new(move.x, 0)
        local move_V = Vector:new(0, move.y)
        local collision_H = false
        local collision_V = false
        for i = 1,#G_hitboxes do
            if G_hitboxes[i] then
                if self.hitboxes["hitbox"]:collide(move_H, G_hitboxes[i]) and self.hitboxes["hitbox"] ~= G_hitboxes[i] then
                    collision_H = true
                end
                if self.hitboxes["hitbox"]:collide(move_V, G_hitboxes[i]) and self.hitboxes["hitbox"] ~= G_hitboxes[i] then
                    collision_V = true
                end
                if collision_H and collision_V then
                    self.goal = nil
                    break
                end
            end
        end

        local finalMove = Vector:new(0, 0)
        if not collision_H then
            finalMove = finalMove + move_H
        end
        if not collision_V then
            finalMove = finalMove + move_V
        end
        self.pos = self.pos + finalMove

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