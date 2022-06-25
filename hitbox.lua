Vector = require("vector")

--- Class representing Hitboxes and Hurtboxes in the game.
--- @class Hitbox
--- @field pos Vector
--- @field name string
--- @field layers table<string, boolean|nil>
--- @field width number
--- @field height number
--- @field offset Vector
--- @field associatedElement Element|Entity|Monster|Player TODO: should be replace with a global ID system
Hitbox = {width=0, height=0}

--- Constructor of Hitbox
--- @param pos Vector
--- @param name string
--- @param layers table<string, boolean|nil>
--- @param width number
--- @param height number
--- @param offset Vector
--- @param associatedE Element
--- @return Hitbox
function Hitbox:new(pos, name, layers, width, height, offset, associatedE)
    -- offset n'est utile que si on change height et width pour avoir une hitbox personnalisée
    -- (sinon mettre la taille de l'image et pas d'offset)
    local h = {}

    setmetatable(h, self)
    self.__index = self

    h.name = name
    h.pos = pos or Vector:new(0, 0)
    h.layers = layers

    if offset then
        h.offset = offset
        h.pos = h.pos + offset
    end

    h.width=width - 1 or self.width
    h.height=height - 1 or self.height

    h.associatedElement = associatedE

    return h
end

-- ----- Ci-gît l'ancien algorithme de collision... -----
-- - RIP in peace (= RIP in peace in peace (= RIP in peace in peace in peace (= ...)))
-- - Lucien : "J'ai fini de corriger l'algorithme des Hitbox", pour la 150ème fois
-- - Kenzo, à 1h du matin : "Ça marche pas"

-- --- Tests if the Hitbox is overlapping with another Hitbox h after a move m
-- --- @param m Vector
-- --- @param h Hitbox
-- --- @return boolean
-- function Hitbox:collideBugged(m, h)
--     local temp_pos = self.pos + m
--     -- correspond au cas ou la hitbox h collide en haut à gauche de la hitbox self
--     if temp_pos.x <= (h.pos.x+h.width) and temp_pos.x >= h.pos.x and temp_pos.y <= (h.pos.y+h.height) and temp_pos.y >= h.pos.y then
--         return true
--     -- correspond au cas ou la hitbox h collide en bas à gauche de la hitbox self
--     elseif (temp_pos.x+self.width) <= (h.pos.x+h.width) and (temp_pos.x+self.width) >= h.pos.x and temp_pos.y <= (h.pos.y+h.height) and temp_pos.y >= h.pos.y then
--         return true
--     -- correspond au cas ou la hitbox h collide en haut à droite de la hitbox self
--     elseif (h.pos.x+h.width) <= (temp_pos.x+self.width) and (h.pos.x+h.width) >= temp_pos.x and h.pos.y <= (temp_pos.y+self.height) and h.pos.y >= temp_pos.y then
--         return true
--     -- correspond au cas ou la hitbox h collide en bas à droite de la hitbox self
--     elseif h.pos.x <= (temp_pos.x+self.width) and h.pos.x >= temp_pos.x and h.pos.y <= (temp_pos.y+self.height) and h.pos.y >= temp_pos.y then
--         return true
--     else
--         return false
--     end
-- end
-- ------------------------------------------------------


--- Tests if the Hitbox is overlapping with another Hitbox h right now, or after a move m if m is given.
--- @param h Hitbox
--- @param m Vector|nil
--- @return boolean
function Hitbox:collide(h, m)
    local temp_pos = self.pos
    if m then
        temp_pos = self.pos + m
    end
    -- Top left : (pos.x, pos.y)
    -- Bottom Right : (pos.x+width, pos.y+height)
    if temp_pos.x > (h.pos.x + h.width) or (temp_pos.x + self.width) < h.pos.x then
        return false
    elseif (temp_pos.y + self.height) < h.pos.y or temp_pos.y > (h.pos.y + h.height) then
        return false
    else
        return true
    end
end

--- Update the coordinates of the Hitbox (use this after we move, or at each frame).
--- @param pos Vector
function Hitbox:move(pos)
    if self.offset then
        self.pos = pos + self.offset
    end
    self.pos.x = self.pos.x
    self.pos.y = self.pos.y
end

--- Draws the hitbox (used for debugging).
--- @param color number[]|nil (optional) 3 numbers must be given: RGB
function Hitbox:draw(color)

    -- Hitbox rectangles
    love.graphics.setLineWidth(1)
    if color == nil then love.graphics.setColor(0/255, 255/255, 255/255, 100/255)
    else love.graphics.setColor(color[1], color[2], color[3], 100/255) end
    love.graphics.rectangle("line", self.pos.x + 0.5, self.pos.y + 0.5, self.width, self.height)

    -- -- Hitbox corners
    -- love.graphics.setPointSize(4)
    -- love.graphics.setColor(255/255, 0/255, 9/255, 255/255)
    -- love.graphics.points(self.pos.x + 0.5, self.pos.y + 0.5, self.pos.x + self.width + 0.5, self.pos.y + 0.5, self.pos.x + self.width + 0.5, self.pos.y + self.height + 0.5, self.pos.x + 0.5, self.pos.y + self.height + 0.5)

    -- Restore default values
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
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