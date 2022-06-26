
--- Encapsulated Score class.
--- @class Score
-- --- @field private score number
--- @field public addScore fun(context: string, value: number|nil) Function to add points to the score depending on the context.
--- @field public getScore fun() Function to get the score.
-- --- @field public saveScore fun() Function to save the score.
-- --- @field public loadScore fun() Function to load the score.

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
        ["wasHurt"]=-1,
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

    local function saveScore()
        local file = io.open("score.save", "wb")
        if not file then
            return false
        else
            file:write(self.score)
            file:close()
            return true
        end
    end

    local function loadScore()
        local file = io.open("score.save", "rb")
        if not file then
            return false
        else
            self.score = file:read()
            print(self.score)
            file:close()
            return true
        end
    end

    local originalScore = {getScore=getScore, addScore=addScore}

    -- Proxy pattern to prevent access, assigning and reassigning
    local proxy = {}
    local proxy_mt = {
        __index = function(table, key)
            if originalScore[key] then
                return originalScore[key]
            else print("[ERROR] You can't access directly a field of a Score.")
            end
        end,
        __newindex = function()
            print("[ERROR] You can't assign or reassign a field of a Score.")
        end}
    setmetatable(proxy, proxy_mt)

    return proxy
end

-- Testing the security of the Score class
-- local s = newScore()
-- s.test = 5
-- print(s.test)
-- s.addScore = 100
-- print(s.addScore)
-- print(s.getScore)
-- local s2 = newScore()
-- s2.addScore("killedTroll")
-- print(s2.getScore())

return newScore