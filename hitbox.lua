Hitbox = {x=0, y=0, width=0, height=0}

function Hitbox:new(x, y, width, height)
    local h = {}
    setmetatable(h, self)
    self.__index = self

    h.x=x or self.x
    h.y=y or self.y
    h.width=width or self.width
    h.height=height or self.height

    return h
end

function Hitbox:collide(h)
    -- correspond au cas ou la hitbox h collide en haut à gauche de la hitbox self
    if self.x <= (h.x+h.width) and self.x >= h.x and self.y <= (h.y+h.height) and self.y >= h.y then
        return true
    -- correspond au cas ou la hitbox h collide en bas à gauche de la hitbox self
    elseif (self.x+self.width) <= (h.x+h.width) and (self.x+self.width) >= h.x and self.y <= (h.y+h.height) and self.y >= h.y then
        return true
    -- correspond au cas ou la hitbox h collide en haut à droite de la hitbox self
    elseif (h.x+h.width) <= (self.x+self.width) and (h.x+h.width) >= self.x and h.y <= (self.y+self.height) and h.y >= self.y then
        return true
    -- correspond au cas ou la hitbox h collide en bas à droite de la hitbox self
    elseif h.x <= (self.x+self.width) and h.x >= self.x and h.y <= (self.y+self.height) and h.y >= self.y then
        return true
    else
        return false
    end
end

--update hitbox coords (use this after we move)
function Hitbox:move(x, y)
    self.x = x
    self.y = y
end



-- /!\ TEST /!\


-- main_h = Hitbox:new(50, 50, 10, 10)
-- h1 = Hitbox:new(45, 45, 10 ,10)
-- h2 = Hitbox:new(55, 45, 10 ,10)
-- h3 = Hitbox:new(45, 55, 10 ,10)
-- h4 = Hitbox:new(55, 55, 10 ,10)
-- h_not = Hitbox:new(70, 70, 10, 10)
-- h_test = Hitbox:new(45, 52, 10, 5)

-- print(main_h:collide(h1))        -- should return true
-- print(main_h:collide(h2))        -- should return true
-- print(main_h:collide(h3))        -- should return true
-- print(main_h:collide(h4))        -- should return true  
-- print(main_h:collide(h_not))     -- should return false 
-- print(main_h:collide(main_h))    -- should return true
-- print(main_h:collide(h_test))    -- should return true



return Hitbox