-- No inheritance to improve performances
--- Very simplified Class representing Sprites (no inheritance).
--- @class Sprite
--- @field loveImg love.Image
--- @field isSheet boolean
--- @field state string
--- @field width number
--- @field height number
--- @field frames love.Quad[]|nil
Sprite = {}


--- Very simplified Sprite constructor.
--- @param img string
--- @param isSheet boolean
--- @param state string
--- @param width number
--- @param height number
--- @return Sprite s sprite table created on the fly.
function Sprite:new(img, isSheet, state, width, height)
    -- Sprites are created on the fly
    local s = {loveImg = love.graphics.newImage(img), isSheet=isSheet, state=state, width=width, height=height}
    setmetatable(s, self)
    self.__index = self

    if isSheet then
        s.frames = {}
        for y = 0, s.loveImg:getHeight() - height, height do
            for x = 0, s.loveImg:getWidth() - width, width do
                s.frames[#s.frames + 1] = love.graphics.newQuad(x, y, width, width, s.loveImg:getDimensions())
            end
        end
    end

    return s
end

return Sprite