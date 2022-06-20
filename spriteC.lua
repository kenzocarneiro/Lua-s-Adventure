

--- @class SpriteCollection
SpriteCollection = {flipH = 1, flipV = 1, sprites = nil}

--- Constructor of SpriteCollection
--- @param el string the name of the corresponding Element
--- @return SpriteCollection
function SpriteCollection:new(el)
    local sc = {}
    setmetatable(sc, self)
    self.__index = self

    sc.element = el
    sc.sprites = {}

    return sc
end

--- @param sprite Sprite
--- @return nil
function SpriteCollection:adds(sprite)
    self.sprites[sprite.state] = sprite
    if sprite.isSheet then
        sprite.frames = {}
        self.currentFrame = 1
        self.frameTimer = 0
        self.interval = 0.1
        for y = 0, sprite.loveImg:getHeight() - sprite.height, sprite.height do
            for x = 0, sprite.loveImg:getWidth() - sprite.width, sprite.width do
                sprite.frames[#sprite.frames + 1] = love.graphics.newQuad(x, y, sprite.width, sprite.width, sprite.loveImg:getDimensions())
            end
        end
    end
end


--- Function that add a sprite to the collection
--- @param s_img number
--- @param s_isSheet boolean
--- @param s_state string
--- @param s_width number
--- @param s_height number
--- @return nil
function SpriteCollection:add(s_img, s_isSheet, s_state, s_width, s_height)
    self.sprites[s_state] = {state=s_state,
        isSheet=s_isSheet,
        width=s_width,
        height=s_height,
        loveImg = love.graphics.newImage(s_img)}

    if s_isSheet then
        self.sprites[s_state].frames = {}
        self.currentFrame = 1
        self.frameTimer = 0
        self.interval = 0.1
        for y = 0, self.sprites[s_state].loveImg:getHeight() - s_height, s_height do
            for x = 0, self.sprites[s_state].loveImg:getWidth() - s_width, s_width do
                self.sprites[s_state].frames[#self.sprites[s_state].frames + 1] = love.graphics.newQuad(x, y, s_width, s_height, self.sprites[s_state].loveImg:getDimensions())
            end
        end
    end
end

--- Update function of SpriteCollection, called every frames
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

return SpriteCollection