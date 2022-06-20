Vector = require("vector")

Hitbox = {pos = Vector:new(0, 0), width=0, height=0}

-- offset n'est utile que si on change height et width pour avoir une hitbox personnalisée (sinon mettre la taille
-- de l'image et pas d'offset)
function Hitbox:new(pos, width, height, offset)
    local h = {}
    setmetatable(h, self)
    self.__index = self

    h.pos = pos or self.pos

    if offset then
        self.offset = offset
        h.pos = h.pos + offset
    end

    h.width=width or self.width
    h.height=height or self.height

    return h
end

function Hitbox:collide(h)
    -- correspond au cas ou la hitbox h collide en haut à gauche de la hitbox self
    if self.pos.x <= (h.pos.x+h.width) and self.pos.x >= h.pos.x and self.pos.y <= (h.pos.y+h.height) and self.pos.y >= h.pos.y then
        return true
    -- correspond au cas ou la hitbox h collide en bas à gauche de la hitbox self
    elseif (self.pos.x+self.width) <= (h.pos.x+h.width) and (self.pos.x+self.width) >= h.pos.x and self.pos.y <= (h.pos.y+h.height) and self.pos.y >= h.pos.y then
        return true
    -- correspond au cas ou la hitbox h collide en haut à droite de la hitbox self
    elseif (h.pos.x+h.width) <= (self.pos.x+self.width) and (h.pos.x+h.width) >= self.pos.x and h.pos.y <= (self.pos.y+self.height) and h.pos.y >= self.pos.y then
        return true
    -- correspond au cas ou la hitbox h collide en bas à droite de la hitbox self
    elseif h.pos.x <= (self.pos.x+self.width) and h.pos.x >= self.pos.x and h.pos.y <= (self.pos.y+self.height) and h.pos.y >= self.pos.y then
        return true
    else
        return false
    end
end

-- update hitbox coords (use this after we move, or at each frame)
function Hitbox:move(pos)
    self.pos = pos + self.offset
    self.pos.x = self.pos.x - self.width/2
    self.pos.y = self.pos.y - self.height/2
end

-- draws the hitbox, useful to debug
function Hitbox:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.setLineWidth(0.5)
    love.graphics.rectangle("line", self.pos.x, self.pos.y, self.width, self.height)
end



-- /!\ TEST /!\


-- main_h = Hitbox:new(Vector:new(50, 50), 10, 10)
-- h1 = Hitbox:new(Vector:new(45, 45), 10 ,10)
-- h2 = Hitbox:new(Vector:new(55, 45), 10 ,10)
-- h3 = Hitbox:new(Vector:new(45, 55), 10 ,10)
-- h4 = Hitbox:new(Vector:new(55, 55), 10 ,10)
-- h_not = Hitbox:new(Vector:new(70, 70), 10, 10)
-- h_test = Hitbox:new(Vector:new(45, 52), 10, 5)

-- print(main_h:collide(h1))        -- should return true
-- print(main_h:collide(h2))        -- should return true
-- print(main_h:collide(h3))        -- should return true
-- print(main_h:collide(h4))        -- should return true
-- print(main_h:collide(h_not))     -- should return false
-- print(main_h:collide(main_h))    -- should return true
-- print(main_h:collide(h_test))    -- should return true



return Hitbox