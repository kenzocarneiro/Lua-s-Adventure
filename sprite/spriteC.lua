
--- Class representing the collection of Sprites of an Element
--- @class SpriteCollection
--- @field sprites table<string, Sprite>
--- @field frames number
SpriteCollection = {sprites = nil}

--- Constructor of SpriteCollection.
--- @param el string The name of the corresponding Element.
--- @return SpriteCollection
function SpriteCollection:new(el)
    local sc = {}
    setmetatable(sc, self)
    self.__index = self

    sc.element = el
    sc.sprites = {}

    return sc
end

--- Initialize the SpriteCollection with an array of sprites.
--- @param sprites Sprite[]
function SpriteCollection:init(sprites)
    -- iterate over sprites
    for i, sprite in ipairs(sprites) do
        -- add sprite to collection
        self.sprites[sprite.state] = sprite
    end
end

--- Draw function of SpriteCollection.
--- @param state string
--- @param pos number
--- @param frameNumber number
--- @param flipH number|nil
--- @param flipV number|nil
--- @param angle number|nil
function SpriteCollection:draw(state, pos, frameNumber, flipH, flipV, angle)
    flipH = flipH or 1
    flipV = flipV or 1
    angle = angle or 0
    if self.sprites[state].isSheet then
        love.graphics.draw(self.sprites[state].loveImg, self.sprites[state].frames[frameNumber], pos.x, pos.y, math.rad(angle), flipH, flipV, self.sprites[state].middle.x, self.sprites[state].middle.y)
    else
        love.graphics.draw(self.sprites[state].loveImg, pos.x, pos.y, math.rad(angle), flipH, flipV, self.sprites[state].middle.x, self.sprites[state].middle.y)
    end
end

--- Tests if the sprite corresponding to this state is a spriteSheet
--- @param state string
--- @return boolean isSheet
function SpriteCollection:isSpriteSheet(state)
    return self.sprites[state].isSheet
end

--- Get the duration of the frames in the sprite corresponding to the given state
--- @param state string
--- @return number[]|nil
function SpriteCollection:getSpriteFramesDuration(state)
    return self.sprites[state].framesDuration
end

--- Get number of sprites in spriteCollection for the given state.
--- @param state string
--- @return Sprite sprite
function SpriteCollection:getNumberOfSprites(state)
    return #self.sprites[state].frames
end

return SpriteCollection