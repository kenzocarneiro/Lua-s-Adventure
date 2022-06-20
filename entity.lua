Entity = {x = 0, y = 0, speed = 1, width = 8, height = 8, health = 1}

function Entity:new()
    local e = {}
    setmetatable(e, self)
    self.__index = self
    return e
end

function Entity:init(img, is_sheet, width, height)
    self.isSheet = isSheet or false

    -- A finir
    if is_sheet then
        self.spriteSheet = img
        self.spriteQuads = {}
        for y = 0, img:getHeight() - height, height do
            for x = 0, img:getWidth() - width, width do
                self.spriteQuads[#self.spriteQuads + 1] = love.graphics.newQuad(x, y, width, height, img:getDimensions())
            end
        end
    else
        self.sprite = love.graphics.newImage(img)
    end
end

function Entity:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return Entity