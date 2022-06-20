-- Very simplified Class: no inheritance (to improve performance)
--- @class Sprite
--- @field loveImg love.Image
--- @field isSheet boolean
--- @field state string
--- @field width number
--- @field height number
Sprite = {}


-- Very simplified Sprite constructor
--- @param img string
--- @param isSheet boolean
--- @param state string
--- @param width number
--- @param height number
--- @return Sprite
function Sprite:new(img, isSheet, state, width, height)
    -- Sprites are created on the fly
    return {loveImg = love.graphics.newImage(img), isSheet=isSheet, state=state, width=width, height=height}
end

return Sprite