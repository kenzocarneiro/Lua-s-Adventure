
--- Encapsulated Score class.
--- @class Score
-- --- @field private score number
--- @field public addScore fun(context: string, value: number|nil) Function to add points to the score depending on the context.
--- @field public getScore fun() Function to get the score.

--- Constructor of Score.
--- @return Score
local function newScore()
    -- private variables
    local self = {score = 0}

    --- @type table<string, number>
    local contextTranslation = {
        ["killedTroll"]=100,
        ["killedRhino"]=125,
        ["pickupCoin"]=10,
        ["pickupHealthPotion"]=5,
        ["pickupDamagePotion"]=10,
        ["pickupSpeedPotion"]=15,
        ["pickupOther"]=30,
        ["wasHurt"]=-5,
        ["roomFinished"]=500
    }

    --- @type table<string, boolean>
    local contextHasValue = {
        ["pickupCoin"]=true,
        ["wasHurt"]=true,
        ["roomFinished"]=true
    }

    -- public functions
    --- Function to add score
    --- @param context string Context in which score is modified
    --- @param value number|nil A value associated with some contexts
    local function addScore(context, value)
        if contextHasValue[context] then self.score = self.score + contextTranslation[context]*value
        elseif value ~= nil then
            print("[ERROR] You can't use this context with a value")
        else
            self.score = self.score + contextTranslation[context]
        end
    end

    local function getScore()
        return self.score
    end

    local returned_score = {getScore=getScore, addScore=addScore}
    setmetatable(returned_score, {
        __index = function(table, key) print("You can't access this field.") end,
        __newindex = function() print("You can't assign this field.") end})

    return returned_score
end
local s = newScore()
s.addScore = 5
print(s.addScore)
return newScore