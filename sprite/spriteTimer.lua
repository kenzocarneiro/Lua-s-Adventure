
--- @class SpriteTimer
--- @field currentFrame number
--- @field frameTimer number
--- @field interval number
SpriteTimer = {currentFrame=1, frameTimer=0, interval=0.1}

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
--- @param maxFrames number
function SpriteTimer:update(dt, maxFrames)
    self.frameTimer = self.frameTimer + dt
    if self.frameTimer > self.interval then
        self.frameTimer = 0
        self.currentFrame = self.currentFrame + 1
        if self.currentFrame > maxFrames then
            self.currentFrame = 1
        end
    end
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
