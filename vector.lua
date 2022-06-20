--- @class Vector
--- @field x number
--- @field y number
Vector = {x = 0; y = 0}

--- Constructor of Vector.
--- @param x number
--- @param y number
--- @return Vector
function Vector:new(x, y)
    local e = {}
    setmetatable(e, self)
    self.__index = self
    e.x = x or self.x
    e.y = y or self.y
    return e
end

--- String conversion for Vector.
--- @return string
function Vector:__tostring()
    return "Vector(" .. self.x .. ", " .. self.y .. ")"
end

--- Norm of the Vector.
--- @return number
function Vector:__len()
    return math.sqrt(self.x^2 + self.y^2)
end

--- Add to another Vector.
--- @return Vector
function Vector:__add(v)
    return Vector:new(self.x + v.x, self.y + v.y)
end

--- Subtract from another Vector.
--- @return Vector
function Vector:__sub(v)
    return Vector:new(self.x - v.x, self.y - v.y)
end

--- Multiply with a scalar or a Vector.
--- @return Vector|number
function Vector:__mul(v)
    if type(v) == "number" then
        return Vector:new(self.x * v, self.y * v)
    else
        return self.x * v.x + self.y * v.y
    end
end

--- Divide with a scalar.
--- @param a number
--- @return Vector
function Vector:__div(a)
    return Vector:new(self.x / a, self.y / a)
end

--- Test for equality with another Vector.
--- @param v Vector
--- @return boolean
function Vector:__eq(v)
    return self.x == v.x and self.y == v.y
end

--- Negative of the Vector.
--- @return Vector
function Vector:__unm()
    return Vector:new(-self.x, -self.y)
end

--- Normalize the Vector.
--- @return Vector
function Vector:normalized()
    return Vector:new(self.x, self.y) / self:__len()
end

--- Floor the Vector.
--- @return Vector
function Vector:floor()
    return Vector:new(math.floor(self.x), math.floor(self.y))
end

--- Round the Vector.
--- @return Vector
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
