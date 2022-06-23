Entity = require("entity/entity")
Projectile = require("entity/projectile")

--- Class representing the Player.
--- @class Player:Entity Player is a subclass of Entity.
--- @field inventory table
--- @field collectRadius number
Player = Entity:new()
--- Constructor of Player.
--- @return Player
function Player:new() return Entity.new(self) end

--- Initializes the item.
--- @param inventory Item[]|Weapon[]|Consumable[]|Coin[]
--- @param collectRadius number
function Player:init(inventory, collectRadius, ...)
    self.inventory = inventory or {}
    self.maxHealth = 100
    self.currentHealth = self.maxHealth
    self.collectRadius = collectRadius or 10
    self.radiusDisplay = false
    self.gold = 0
    self.nextFreeInventorySlotNum = 1

    --for potion consumming
    self.potion_stock = {3, 1, 1} -- {health, damage, speed}
    self.currentPotion = 1
    self.timer1 = nil
    self.timer2 = nil
    self.buffs = {0, 0}  --damage and speed

    Entity.init(self, ...)
end

--- Update the player (called every frames).
--- @param dt number
function Player:update(dt)

    --update buffs
    self:buffsUpdate(dt)

    --moving
    local move = Vector:new(0, 0)
    if love.keyboard.isDown("right", "d") then
        move = move + Vector:new(1, 0)
        self.spriteCollection.flipH = 1
    end
    if love.keyboard.isDown("left", "q") then
        move = move + Vector:new(-1, 0)
        self.spriteCollection.flipH = -1
    end
    if love.keyboard.isDown("up", "z") then
        move = move + Vector:new(0, -1)
    end
    if love.keyboard.isDown("down", "s") then
        move = move + Vector:new(0, 1)
    end

    --moving and verifying collision
    if move ~= Vector:new(0, 0) then
        if self.state ~= "attack" then self:changeState("run") end
        self:move(move)
    else
        if self.state ~= "attack" then self:changeState("idle") end
    end

    local currentFrame, animationFinished = self.spriteTimer:update(dt, self.spriteCollection:getNumberOfSprites(self.state))

    self.hitboxes["hitbox"]:move(self.pos) -- TODO: move hitbox with element

    -- TODO: Using the sprite frame to define the attack fireRate isn't a good idea.
    if self.state == "attack" and currentFrame == self.spriteCollection:getNumberOfSprites(self.state) - 1 then
        self.hasShoot = true
        local p = Projectile:new()
        local direction = Vector:new(self.spriteCollection.flipH, 0)

        if self.spriteCollection.flipH == 1 then
            p:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, G_fireballHF)
        elseif self.spriteCollection.flipH == -1 then
            p:init(direction, 5, "bullet", self.pos + Vector:new(-9, 5), G_fireballSC, G_fireballHF)
        end
        G_hurtboxes[#G_hurtboxes + 1] = p.hitboxes["hurtbox"]

        G_projectiles[#G_projectiles+1] = p
        G_hitboxes[#G_hitboxes+1] = p.hitboxes["hitbox"]
        self.state = "idle"
    end
end

--- Draw the Player.
--- @param draw_hitbox boolean
function Player:draw(draw_hitbox)

    if self.radiusDisplay then
        love.graphics.setLineWidth(0.3)
        love.graphics.circle("line", self.pos.x, self.pos.y, self.collectRadius)
    end

    Entity.draw(self, draw_hitbox)
end


--- allow the Player to pickup items
--- @param item Item|Weapon|Consumable|Coin
--- @return boolean --true if we pickup the item, false if we cant
function Player:pickup(item)
local inventory_size = 5

    local itemX = item.pos.x
    local itemY = item.pos.y

    if ((itemX-self.pos.x)^2 + (itemY - self.pos.y)^2) <= (self.collectRadius^2) then

        --potions
        if tostring(item)=="Consumable" then
            --potion de vie
            if item.target =="health" then
                self.potion_stock[1] = self.potion_stock[1] + 1
            --potion buff de dommages
            elseif item.target =="damage" then
                self.potion_stock[2] = self.potion_stock[2] + 1
            --potion de vitesse
            elseif item.target =="speed" then
                self.potion_stock[3] = self.potion_stock[3] + 1
            end

        -- objet permanent
        else
            -- si on a de la place
            if self.nextFreeInventorySlotNum <= 5 and tostring(item) ~= "Coin" then
                self.nextFreeInventorySlotNum = self.nextFreeInventorySlotNum + 1
                self.inventory[#self.inventory+1] = item
            end
        end
        return true
    end
    return false
end

function Player:__tostring()
    return "Player"
end

function Player:ApplyHealthPotionEffect(pAmount)
    if (self.potion_stock[self.currentPotion] == 0) then
        print(" t'as plus de potions frérot !")
    elseif self.currentPotion == 1 then
        self.potion_stock[1] = self.potion_stock[1] - 1
        -- on s'assure qu'il ne peut pas regen plus que sa vie max
        if self.currentHealth +  pAmount > self.maxHealth then
            self.currentHealth = self.maxHealth
        else
            self.currentHealth =self.currentHealth + pAmount
        end
        G_hud.player.elements["healthBar"]:modifyValue(pAmount)
    elseif self.currentPotion == 2 then
        self:consume()
    elseif self.currentPotion == 3 then
        self:consume()
    end

end


function Player:consume()
    self.potion_stock[self.currentPotion] = self.potion_stock[self.currentPotion] - 1
    if self.currentPotion == 2 then
        self.buffs[1] = self.buffs[1] + 5
        self.damage = self.damage + self.buffs[1]
        self.timer1 = Timer:new(10)
    elseif self.currentPotion == 3 then
        self.buffs[2] = self.buffs[2] + 2
        self.speed = self.speed + self.buffs[2]
        self.timer2 = Timer:new(10)
    end

end

function Player:CastSpell()
local p = {}
-- local direction = {}
--     for i=1, 6 do
--         p[i] = Projectile:new()
--         direction[i]= self:cylToCart(1, math.rad(i*45))
--         p[i]:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, G_fireballHF)
--         G_projectiles[#G_projectiles+1] = p[i]
--         G_hitboxes[#G_hitboxes+1] = p[i].hitboxes["hitbox"]
--     end

    -- right
    local p1 =  {}
    p1 = Projectile:new()
    local direction = self:cylToCart(1, 0)
    p1:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, G_fireballHF)
    G_projectiles[#G_projectiles+1] = p1
    G_hitboxes[#G_hitboxes+1] = p1.hitboxes["hitbox"]

    -- left
    local p2 =  {}
    p2 = Projectile:new()
    direction = self:cylToCart(1, math.rad(180))
    p2:init(direction, 5, "bullet", self.pos + Vector:new(-9, 5), G_fireballSC, G_fireballHF)
    G_projectiles[#G_projectiles+1] = p2
    G_hitboxes[#G_hitboxes+1] = p2.hitboxes["hitbox"]

     -- top
     local p3 =  {}
     p3 = Projectile:new()
    direction = Vector:new(0,1)
     p3:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, G_fireballHF)
     G_projectiles[#G_projectiles+1] = p3
     G_hitboxes[#G_hitboxes+1] = p3.hitboxes["hitbox"]

    -- bottom
    local p4 =  {}
    p4 = Projectile:new()
   direction = Vector:new(0,-1)
    p4:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, G_fireballHF)
    G_projectiles[#G_projectiles+1] = p4
    G_hitboxes[#G_hitboxes+1] = p4.hitboxes["hitbox"]


    -- bottom
    local p5 =  {}
    p5 = Projectile:new()
   direction = Vector:new(-1,-1)
    p5:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, G_fireballHF)
    G_projectiles[#G_projectiles+1] = p5
    G_hitboxes[#G_hitboxes+1] = p5.hitboxes["hitbox"]

    -- bottom
    local p6 =  {}
    p6 = Projectile:new()
   direction = Vector:new(1,-1)
    p6:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, G_fireballHF)
    G_projectiles[#G_projectiles+1] = p6
    G_hitboxes[#G_hitboxes+1] = p6.hitboxes["hitbox"]

   -- bottom
   local p8 =  {}
   p8 = Projectile:new()
  direction = Vector:new(-1,1)
   p8:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, G_fireballHF)
   G_projectiles[#G_projectiles+1] = p8
   G_hitboxes[#G_hitboxes+1] = p8.hitboxes["hitbox"]

   -- bottom
   local p7 =  {}
   p7 = Projectile:new()
  direction = Vector:new(1,1)
   p7:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, G_fireballHF)
   G_projectiles[#G_projectiles+1] = p7
   G_hitboxes[#G_hitboxes+1] = p7.hitboxes["hitbox"]



end
-- r : longueur : math.sqrt(x*x + y+y)
-- theta en radian :  math.atan(y / x)
function Player:convCartToCyl(x, y)
    local resultat = Vector:new(math.sqrt(x*x + y+y),  math.atan(y / x))
    return resultat
end

function Player:cylToCart(r, theta)
    local resultat = Vector:new(r * math.cos(theta),  r * math.sin(theta))
    return resultat
end

function Player:buffsUpdate(dt)
    if self.timer1 and self.timer1:update(dt) then
        self.damage = self.damage - self.buffs[1]
        self.buffs[1] = self.buffs[1] - 5
        self.timer1 = nil
    end
    if self.timer2 and self.timer2:update(dt) then
        self.speed = self.speed - self.buffs[2]
        self.buffs[2] = self.buffs[2] - 2
        self.timer2 = nil
    end
end

return Player