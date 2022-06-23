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
--- @param inventory table
--- @param collectRadius number
function Player:init(inventory, collectRadius, ...)
    self.inventory = inventory or {}
    self.potion_stock = 3
    self.maxHealth = 100
    self.currentHealth = self.maxHealth
    self.collectRadius = collectRadius or 10
    self.radiusDisplay = false
    self.gold = 0
    self.nextFreeInventorySlotNum = 1

    Entity.init(self, ...)
end

--- Update the player (called every frames).
--- @param dt number
function Player:update(dt)

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
--- @param item Item
--- @return boolean --true if we pickup the item, false if we cant
function Player:pickup(item)
local inventory_size = 5

    local itemX = item.pos.x
    local itemY = item.pos.y

    if ((itemX-self.pos.x)^2 + (itemY - self.pos.y)^2) <= (self.collectRadius^2) then

        --potion de vie
        if tostring(item)=="Consumable" then
            if item.target =="health" then
            self.potion_stock =self.potion_stock + 1
            end

        -- objet permanent
        else
            -- si on a de la place
            if self.nextFreeInventorySlotNum <= 5 and tostring(item) ~= "Coin" then
                self.nextFreeInventorySlotNum = self.nextFreeInventorySlotNum + 1
                print("next free slot : " .. self.nextFreeInventorySlotNum)
                self.inventory[#self.inventory+1] = item
             --   G_hud:updateInvSlot(self.nextFreeInventorySlotNum, item.spriteCollection.sprites["idle"].loveImg)
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
    if (self.potion_stock == 0) then
        print(" t'as plus de potions frérot !")
    else
        self.potion_stock = self.potion_stock - 1
        -- on s'assure qu'il ne peut pas regen plus que sa vie max
        if self.currentHealth +  pAmount > self.maxHealth then
            self.currentHealth = self.maxHealth
        else
            self.currentHealth =self.currentHealth + pAmount
        end
        G_hud.player.elements["healthBar"]:modifyValue(pAmount)

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

return Player