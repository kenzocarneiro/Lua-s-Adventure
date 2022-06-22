local Field = {}

--constructor
function Field:new(x, y)
    -- local img = love.graphics.newImage("field.png")
    local r = {x=x, y=y, w=700, h=500}--, img=img} --store the top-left corner of the field
    -- lines are not drawn but it's not important
    local lineTop = love.graphics.line(r.x, r.y, r.x + r.h, r.y)
    local lineBottom = love.graphics.line(r.x, r.y + r.h, r.x + r.h, r.y + r.h)
    local lineLeft = love.graphics.line(r.x, r.y, r.x, r.y + r.h)
    local lineRight = love.graphics.line(r.x + r.w, r.y, r.x + r.h, r.y + r.h)
    
    r.line = {lineTop, lineBottom, lineLeft, lineRight}
    self.__index = self
    setmetatable(r, self)
    return r
end

--setters

function Field:draw()
    love.graphics.setLineWidth(2)
    for _, line in ipairs(self.line) do
        love.graphics.draw(line)
    end
end

--getters

function Field:top()
    return self.y
end

function Field:bottom()
    return self.y + self.h
end

function Field:left()
    return self.x
end

function Field:right()
    return self.x + self.w
end

-- for import with require
return Field