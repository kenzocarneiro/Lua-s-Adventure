-- No inheritance to improve performances
--- Very simplified Class representing Sprites (no inheritance).
--- @class Sprite
--- @field loveImg love.Image
--- @field isSheet boolean
--- @field state string
--- @field width number
--- @field height number
--- @field middle Vector
--- @field frames love.Quad[]|nil
--- @field twoDFrames boolean|nil
--- @field framesDuration number[]|nil
Sprite = {}


--- Very simplified Sprite constructor.
--- @param img string
--- @param isSheet boolean
--- @param state string
--- @param width number
--- @param height number
--- @param middle Vector|nil
--- @param twoDFrames boolean|nil
--- @param framesDuration number[]|nil
--- @return Sprite s sprite table created on the fly.
function Sprite:new(img, isSheet, state, width, height, middle, twoDFrames, framesDuration)
    -- Sprites are created on the fly
    local s = {loveImg = love.graphics.newImage(img), isSheet=isSheet, state=state, width=width, height=height, middle=middle or Vector:new(math.floor(width/2), math.floor(height/2)), twoDFrames=twoDFrames, framesDuration=framesDuration}
    setmetatable(s, self)
    self.__index = self
    if isSheet then
        if twoDFrames then
            s.frames = {}
            for y = 0, s.loveImg:getHeight()/height do
                s.frames[y] = {}
                for x = 0, s.loveImg:getWidth()/width do
                    s.frames[y][x] = love.graphics.newQuad(x*height, y*width, width, height, s.loveImg:getDimensions())
                end
            end
        else
            s.frames = {}
            for y = 0, s.loveImg:getHeight() - height, height do
                for x = 0, s.loveImg:getWidth() - width, width do
                    s.frames[#s.frames + 1] = love.graphics.newQuad(x, y, width, height, s.loveImg:getDimensions())
                end
            end
        end
    end

    return s
end

return Sprite