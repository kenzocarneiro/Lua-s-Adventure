
local img = love.graphics.newImage("easteregg/Pong/racket.png")
local Racket = {x=0, y=0, w=20, h=100, img=img}

--constructor
function Racket:new(x, y)
    local r = {} --store the top-left corner of the racket
    r.x = x
    r.y = y
    self.__index = self
    setmetatable(r, self)
    return r
end

--setters

function Racket:moveX(dx)
    self.x = self.x + dx
end

function Racket:moveY(dy)
    self.y = self.y + dy
end

function Racket:draw()
    love.graphics.draw(self.img, self.x, self.y)
end

--getters

function Racket:top()
    return self.y
end

function Racket:bottom()
    return self.y + self.h
end

function Racket:left()
    return self.x
end

function Racket:right()
    return self.x + self.w
end

-- for import with require
return Racket