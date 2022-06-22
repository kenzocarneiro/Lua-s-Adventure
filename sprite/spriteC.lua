
--- Class representing the collection of Sprites of an Element
--- @class SpriteCollection
--- @field sprites table<string, Sprite>
--- @field flipH number
--- @field flipV number
--- @field frames number
SpriteCollection = {flipH = 1, flipV = 1, sprites = nil}

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
function SpriteCollection:draw(state, pos, frameNumber, flipH, flipV)
    flipH = flipH or self.flipH
    flipV = flipV or self.flipV
    love.graphics.draw(self.sprites[state].loveImg, self.sprites[state].frames[frameNumber], pos.x, pos.y, 0, flipH, flipV, self.sprites[state].middle.x, self.sprites[state].middle.y)
end

--- Get number of sprites in spriteCollection for the given state.
--- @param state string
--- @return Sprite sprite
function SpriteCollection:getNumberOfSprites(state)
    return #self.sprites[state].frames
end

return SpriteCollection