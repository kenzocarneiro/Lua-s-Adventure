
local Data = require("data")

--- Class representing the IA of the boss (state machine IA)
--- @class bossIA
--- @field state string
--- @field substate string
--- @field timer Timer
--- @field subTimer Timer
--- @field subLaunched boolean
--- @field moveTimer Timer
bossIA = {}

--- Constructor of stateMachineIA.
--- @return bossIA
function bossIA:new()
    local e = {}
    setmetatable(e, self)
    self.__index = self

    e.state = "moveAngry"
    e.substate = "moveBL"

    e.timer = Timer:new(1)
    e.subTimer = Timer:new(0.3)
    e.subLaunched = false
    e.moveTimer = Timer:new(10)

    return e
end

-- --- Initializes the entity.
-- --- @param speed number
-- --- @param weapon string
-- --- @param pos Vector
-- --- @param spriteCollection SpriteCollection
-- --- @param hitboxFactory HitboxFactory|nil
-- function Entity:init(speed, weapon, pos, spriteCollection, hitboxFactory)
--     self.speed = speed or 1
--     self.weapon = weapon or "epee"
--     self.hasShoot = false
--     self.damage = 10

--     Element.init(self, pos, spriteCollection, hitboxFactory)
-- end


--- @param dt number
--- @param boss Monster
--- @param player Player
function bossIA:attackUpdate(dt, boss, player)
    local hasFinished = self.timer:update(dt)
    local subHasFinished = false
    if self.subLaunched then
        subHasFinished = self.subTimer:update(dt)
    end

    if subHasFinished then
        local direction_step
        if self.state == "attackAngry" then direction_step = 30 else direction_step = 45 end
        for i=0, 360 - direction_step, direction_step do
                local p = Projectile:new()
                p:init(boss.damage, i, 5, "bullet", boss.pos + Vector:new(0, 0), Data.fireballSC, Data.G_enemyFireBallHF)
        end
        self.subLaunched = false
        -- if self.substate == "moveBL" then

        -- elseif self.substate == "moveBR" then

        -- elseif self.substate == "moveTL" then

        -- elseif self.substate == "moveTR" then

        -- end
    end


    if hasFinished then
        local randstate = math.random(1, 6)
        if randstate == 1 then
            if self.state == "attackAngry" then self.state = "moveAngry" else self.state = "move" end
            self.timer:reset()
            self.subTimer:reset()
        else
            self.subLaunched = true
            local randmove = math.random(1, 4)
            local stateTab = {
                "moveTL",
                "moveTR",
                "moveBR",
                "moveBL"
            }
            local moveTranslation = {
                ["moveTL"] = Vector:new(50, 50),
                ["moveTR"] = Vector:new(270, 50),
                ["moveBR"] = Vector:new(270, 130),
                ["moveBL"] = Vector:new(50, 130)
            }

            -- if self.substate == "moveBL" then
            --     self.substate = movetab
            --     return "pos", Vector:new(50, 130) -- bottom left
            -- elseif self.substate == "moveBR" then
            --     self.substate = "moveTR"
            --     return "pos", Vector:new(270, 130) -- bottom right
            -- elseif self.substate == "moveTL" then
            --     self.substate = "moveBL"
            --     return "pos", Vector:new(50, 50) -- top left
            -- elseif self.substate == "moveTR" then
            --     self.substate = "moveTL"
            --     return "pos", Vector:new(270, 50) -- top right
            -- end
            self.subState = stateTab[randmove]
            print("moveTranslation", moveTranslation[self.subState])
            return "pos", moveTranslation[self.subState]
        end
    end
end
-- Vector:new(50, 50) top left
-- Vector:new(270, 50) top right
-- Vector:new(270, 130) bottom right
-- Vector:new(50, 130) bottom left

function bossIA:updateMove(dt, boss, player)
    Monster.move(boss, player.pos)
    local hasFinished = self.moveTimer:update(dt)
    if hasFinished then
        if self.state == "moveAngry" then self.state = "attackAngry" else self.state = "attack" end
        self.moveTimer:reset()
    end
end

--- Update the entity (called every frames).
--- @param dt number
function bossIA:update(dt, boss, player)
    if self.state == "attack" or self.state == "attackAngry" then
        return self:attackUpdate(dt, boss, player)
    elseif self.state == "move" then
        boss.speed = 0.5
        self:updateMove(dt, boss, player)
    elseif self.state == "moveAngry" then
        boss.speed = 0.7
        self:updateMove(dt, boss, player)
    end
end

function bossIA:__tostring()
    return "bossIA"
end

return bossIA