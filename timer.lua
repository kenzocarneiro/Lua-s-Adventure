
--- @class Timer
--- @field time number
--- @field maxTime number
--- @field oneshot boolean
Timer = {maxTime=1}

--- Constructor of Timer
--- @return Timer
function Timer:new(maxTime)
    local sc = {}
    setmetatable(sc, self)
    self.__index = self

    sc.time = 0
    sc.maxTime = maxTime or self.maxTime

    return sc
end

--- Update function of the Timer (called every frames).
--- @param dt number
--- @return boolean hasFinished
function Timer:update(dt)
    self.time = self.time + dt
    if self.time > self.maxTime then
        self.time = 0
        return true
    end
    return false
end

--- Reset timer time.
function Timer:reset()
    self.time = 0
end

return Timer
