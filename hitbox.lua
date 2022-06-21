Vector = require("vector")

--- Class representing Hitboxes and Hurtboxes in the game.
--- @class Hitbox
--- @field pos Vector
--- @field width number
--- @field height number
--- @field offset Vector
Hitbox = {width=0, height=0}

--- Constructor of Hitbox
--- @param pos Vector
--- @param width number
--- @param height number
--- @param offset Vector
--- @return Hitbox
function Hitbox:new(pos, width, height, offset)
    -- offset n'est utile que si on change height et width pour avoir une hitbox personnalisée
    -- (sinon mettre la taille de l'image et pas d'offset)
    local h = {}

    setmetatable(h, self)
    self.__index = self

    h.pos = pos or Vector:new(0, 0)

    if offset then
        h.offset = offset
        h.pos = h.pos + offset
    end

    h.width=width or self.width
    h.height=height or self.height

    return h
end

--- Tests if the Hitbox is overlapping with another Hitbox h after a move m
--- @param m Vector
--- @param h Hitbox
--- @return boolean
function Hitbox:collide(m, h)
    local temp_pos = self.pos + m
    -- correspond au cas ou la hitbox h collide en haut à gauche de la hitbox self
    if temp_pos.x <= (h.pos.x+h.width) and temp_pos.x >= h.pos.x and temp_pos.y <= (h.pos.y+h.height) and temp_pos.y >= h.pos.y then
        return true
    -- correspond au cas ou la hitbox h collide en bas à gauche de la hitbox self
    elseif (temp_pos.x+self.width) <= (h.pos.x+h.width) and (temp_pos.x+self.width) >= h.pos.x and temp_pos.y <= (h.pos.y+h.height) and temp_pos.y >= h.pos.y then
        return true
    -- correspond au cas ou la hitbox h collide en haut à droite de la hitbox self
    elseif (h.pos.x+h.width) <= (temp_pos.x+self.width) and (h.pos.x+h.width) >= temp_pos.x and h.pos.y <= (temp_pos.y+self.height) and h.pos.y >= temp_pos.y then
        return true
    -- correspond au cas ou la hitbox h collide en bas à droite de la hitbox self
    elseif h.pos.x <= (temp_pos.x+self.width) and h.pos.x >= temp_pos.x and h.pos.y <= (temp_pos.y+self.height) and h.pos.y >= temp_pos.y then
        return true
    else
        return false
    end
end

--- Update the coordinates of the Hitbox (use this after we move, or at each frame).
--- @param pos Vector
function Hitbox:move(pos)
    self.pos = pos + self.offset
    self.pos.x = self.pos.x - self.width/2
    self.pos.y = self.pos.y - self.height/2
end

--- Draws the hitbox (used for debugging).
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