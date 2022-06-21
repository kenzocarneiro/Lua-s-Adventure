local Ball = {}

--constructor
function Ball:new(x, y)
    local img = love.graphics.newImage("ball.png")
    local r = {x=x, y=y, w=10, h=10, dx=5, dy=5, img=img} -- store the middle of the ball
    self.__index = self
    setmetatable(r, self)
    return r
end

--setters

function Ball:getDX()
    return self.dx
end

function Ball:getDY()
    return self.dx
end

function Ball:mulDX(coeff)
    self.dx = self.dx * coeff
end

function Ball:mulDY(coeff)
    self.dy = self.dy * coeff
end

function Ball:move()
    self.x = self.x + self.dx
    self.y = self.y + self.dy
end

function Ball:place(x, y)
    self.x = x
    self.y = y
end

function Ball:draw()
    love.graphics.draw(self.img, self.x - self.w/2, self.y - self.h/2)
end

--getters

function Ball:top()
    return self.y - self.h/2
end

function Ball:bottom()
    return self.y + self.h/2
end

function Ball:left()
    return self.x - self.w/2
end

function Ball:right()
    return self.x + self.w/2
end

-- for import with require
return Ball