
--- Class representing the collection of Sprites of an Element
--- @class SpriteCollection
--- @field sprites table<string, Sprite>
--- @field flipH number
--- @field flipV number
--- @field frames number
SpriteCollection = {flipH = 1, flipV = 1, sprites = nil, currentFrame=1, frameTimer=0, interval=0.1}

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

--- Update function of SpriteCollection (called every frames).
--- @param dt number
--- @param state string
function SpriteCollection:update(dt, state)
    if self.sprites[state].isSheet then
        self.frameTimer = self.frameTimer + dt
        if self.frameTimer > self.interval then
            self.frameTimer = 0
            self.currentFrame = self.currentFrame + 1
            if self.currentFrame > #self.sprites[state].frames then
                self.currentFrame = 1
            end
        end
    end
end

function SpriteCollection:draw(state, draw_hitbox, pos)
    love.graphics.draw(self.sprites[state].loveImg, self.sprites[state].frames[self.currentFrame], pos.x, pos.y, 0, self.flipH, self.flipV, self.sprites[state].width/2, self.sprites[state].height/2)
end

function SpriteCollection:changeState(state)
    self.frameTimer = 0
    self.currentFrame = 0
end

return SpriteCollection