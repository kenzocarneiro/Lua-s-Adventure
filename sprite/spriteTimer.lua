
--- @class SpriteTimer
--- @field currentFrame number
--- @field frameTimer number
--- @field interval number
SpriteTimer = {currentFrame=1, frameTimer=0, frameInterval=0.1}

--- Constructor of SpriteTimer
--- @return SpriteTimer
function SpriteTimer:new()
    local sc = {}
    setmetatable(sc, self)
    self.__index = self
    return sc
end

--- Update function of the SpriteTimer (called every frames).
--- @param dt number
--- @param framesInterval number[]|nil
--- @param maxFrames number
--- @return number currentFrame, boolean animationFinished
function SpriteTimer:update(dt, framesInterval, maxFrames)
    local currentFrameInterval
    if framesInterval then
        currentFrameInterval = framesInterval[self.currentFrame]
    else
        currentFrameInterval = self.frameInterval
    end
    self.frameTimer = self.frameTimer + dt
    if self.frameTimer > currentFrameInterval then
        self.frameTimer = 0
        self.currentFrame = self.currentFrame + 1
        if self.currentFrame > maxFrames then
            self.currentFrame = 1
            return self.currentFrame, true
        end
        return self.currentFrame, false
    end
    return self.currentFrame, false
end

--- Changes the state of the SpriteTimer.
function SpriteTimer:changeState()
    self.frameTimer = 0
    self.currentFrame = 1
end

--- Get current frame of SpriteTimer
--- @return number
function SpriteTimer:getCurrentFrame()
    return self.currentFrame
end

return SpriteTimer
