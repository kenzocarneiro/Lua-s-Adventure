Vector = {x = 0; y = 0}

function Vector:new(x, y)
    local e = {}
    setmetatable(e, self)
    self.__index = self
    e.x = x or self.x
    e.y = y or self.y
    return e
end

function Vector:__tostring()
    return "Vector(" .. self.x .. ", " .. self.y .. ")"
end

function Vector:__len()
    return math.sqrt(self.x^2 + self.y^2)
end

function Vector:__add(v)
    return Vector:new(self.x + v.x, self.y + v.y)
end

function Vector:__sub(v)
    return Vector:new(self.x - v.x, self.y - v.y)
end

function Vector:__mul(v)
    if type(v) == "number" then
        return Vector:new(self.x * v, self.y * v)
    else
        return self.x * v.x + self.y * v.y
    end
end

function Vector:__div(a)
    return Vector:new(self.x / a, self.y / a)
end

function Vector:__eq(a)
    return self.x == a.x and self.y == a.y
end

function Vector:__unm(a)
    return Vector:new(-self.x, -self.y)
end

function Vector:normalized()
    return Vector:new(self.x, self.y) / self:__len()
end

function Vector:floor()
    return Vector:new(math.floor(self.x), math.floor(self.y))
end

function Vector:round()
    return Vector:new(math.floor(self.x + 0.5), math.floor(self.y + 0.5))
end

-- -- Testing Vectors --
-- victor = Vector:new(1, 1)
-- print(victor)
-- print(#victor)
-- print(victor + Vector:new(1, 1))
-- print(victor - Vector:new(2, 2))
-- print(victor * Vector:new(2, 2))
-- print(victor / 2)
-- print(victor == Vector:new(1, 1))
-- print(victor == Vector:new(1, 2))
-- print(victor ~= Vector:new(1, 1))
-- print(victor ~= Vector:new(1, 2))
-- print(-victor)


return Vector
