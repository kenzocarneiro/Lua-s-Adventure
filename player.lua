Player = {x = 0, y = 0, speed = 1, width = 18, height = 18}

function Player:new(img, is_sheet, width, height)
    local p = {}
    setmetatable(p, self)
    self.__index = self

    p.is_sheet = is_sheet or false -- This returns a boolean instead of "nil"

    -- A finir
    if is_sheet then
        p.sprite_sheet = img
        p.sprite_quads = {}
        for y = 0, img:getHeight() - height, height do
            for x = 0, img:getWidth() - width, width do
                p.sprite_quads[#p.sprite_quads + 1] = love.graphics.newQuad(x, y, width, height, img:getDimensions())
            end
        end
    else
        p.sprite = love.graphics.newImage(img)
    end
    return p
end

function Player:update()
    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed
    end
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed
    end
    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed
    end
    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed
    end
end

function Player:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end




return Player