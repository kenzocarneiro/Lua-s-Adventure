Entity = require("entity/entity")
Projectile = require("entity/projectile")
Score = require("score")

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
    self.maxEnergy = 10
    self.currentEnergy = 0
   -- self.skillAngleCd = 0 or 0
    self.energyTimer = Timer:new(0.1)
    self.damage = 4
    self.maxHealth = 100
    self.targetHealth = 100
    self.currentHealth = self.maxHealth
    self.collectRadius = collectRadius or 10
    self.radiusDisplay = false
    self.gold = 0
    self.nextFreeInventorySlotNum = 1
    self.score = Score()
    self.selectedWeapon = nil

    --for potion consumming
    self.potion_stock = {3, 1, 1} -- {health, damage, speed}
    self.currentPotion = 1
    self.timer1 = nil
    self.timer2 = nil
    self.buffs = {0, 0}  --damage and speed


    Entity.init(self, ...)
end

--- Hurt the Player and check if they are dead.
--- @param damage number
--- @param pos Vector|nil
--- @return boolean isDead tells if the entity is dead
function Player:hurt(damage, pos)
    if not self.invulnerable then self.score.addScore("wasHurt", damage) end
    return Entity.hurt(self, damage, pos)
end

--- Update the player (called every frames).
--- @param dt number
function Player:update(dt)

    --update buffs
    self:buffsUpdate(dt)

    --update energy
    self:energyUpdate(dt)

    --moving
    if self.state ~= "special" then
        local move = Vector:new(0, 0)
        if love.keyboard.isDown("right", "d") then
            move = move + Vector:new(1, 0)
            self.flipH = 1
        end
        if love.keyboard.isDown("left", "q") then
            move = move + Vector:new(-1, 0)
            self.flipH = -1
        end
        if love.keyboard.isDown("up", "z") then
            move = move + Vector:new(0, -1)
        end
        if love.keyboard.isDown("down", "s") then
            move = move + Vector:new(0, 1)
        end

        --moving and verifying collision
        if move ~= Vector:new(0, 0) then
            if self.state == "idle" then self:changeState("run") end
            self:move(move)
        else
            if self.state == "run" then self:changeState("idle") end
        end
    end

    local currentFrame, animationFinished = self.spriteTimer:update(dt, self.spriteCollection:getSpriteFramesDuration(self.state), self.spriteCollection:getNumberOfSprites(self.state))

    -- attack handling
    if self.state == "attack" then

        if currentFrame == 4 and not self.hasShoot then
            if G_soundEffectsOn then
                local sound = love.audio.newSource("sound/soundeffects/player_attack.wav", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
                sound:setVolume(0.5)
                sound:play()
            end
            self.hasShoot = true
            local p = Projectile:new()
            local direction = Vector:new(self.flipH, 0)

            if self.flipH == 1 then
                p:init(direction, 5, "bullet", self.pos + Vector:new(9, 5), G_fireballSC, G_fireballHF)
            elseif self.flipH == -1 then
                p:init(direction, 5, "bullet", self.pos + Vector:new(-9, 5), G_fireballSC, G_fireballHF)
            end

        elseif animationFinished then
            self.state = "idle"
            self.hasShoot = false
        end
    elseif self.state == "special" then
        G_blackoutCurrentFrame = 250 - (currentFrame - 1)*25
        if animationFinished then
            self.state = "idle"
            self.hasShoot = false
        elseif G_gandalf and currentFrame == 1 and not G_blackoutSFX then
            local sound = love.audio.newSource("ysnp.mp3", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
            sound:setVolume(1)
            sound:play()
            G_blackoutSFX = true
        elseif currentFrame == 2 then -- Not 1 because when the animation is finished it is in frame 1
            G_blackoutOnPlayer = true
            G_blackoutSFX = false
        elseif currentFrame == 7 then
            self.hasShoot = true
            self:castSpell()
            G_blackoutCurrentFrame = 250 - (currentFrame - 2)*25
        elseif currentFrame == 8 then
            G_blackoutCurrentFrame = 250 - (currentFrame - 3)*25
        elseif currentFrame == 9 then
            G_blackoutOnPlayer = false
        end
    end

    Entity.update(self, dt, true)
end

--- Draw the Player.
function Player:draw()

    if self.radiusDisplay then
        love.graphics.setLineWidth(0.3)
        love.graphics.circle("line", self.pos.x, self.pos.y, self.collectRadius)
    end

    Entity.draw(self)
end


--- allow the Player to pickup items
--- @param item Item|Weapon|Consumable|Coin
--- @return boolean --true if we pickup the item, false if we cant
function Player:pickup(item)
local inventory_size = 5

    local itemX = item.pos.x
    local itemY = item.pos.y

    if ((itemX-self.pos.x)^2 + (itemY - self.pos.y)^2) <= (self.collectRadius^2) then

        local coinSound = love.audio.newSource("sound/soundeffects/coin.wav","static")
        local itemSound = love.audio.newSource("sound/soundeffects/pickup.wav", "static") -- the "stream" argument instead of "static" tells LÖVE to stream the file from disk, good for longer music tracks
        --coins
        if tostring(item) == "Coin" then
            self.gold = self.gold + item.value
            self.score.addScore("pickupCoin", item.value)
            coinSound:setVolume(0.2)
            coinSound:play()
        --potions
        elseif tostring(item)=="Consumable" then
            itemSound:setVolume(0.2)
            itemSound:play()
            --potion de vie
            if item.target =="health" then
                self.score.addScore("pickupHealthPotion")
                self.potion_stock[1] = self.potion_stock[1] + 1
            --potion buff de dommages
            elseif item.target =="damage" then
                self.score.addScore("pickupDamagePotion")
                self.potion_stock[2] = self.potion_stock[2] + 1
            --potion de vitesse
            elseif item.target =="speed" then
                self.score.addScore("pickupSpeedPotion")
                self.potion_stock[3] = self.potion_stock[3] + 1
            end

        -- objet permanent
        else
            self.score.addScore("pickupOther")
            itemSound:setVolume(0.2)
            itemSound:play()
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

function Player:applyPotionEffect(pAmount)
    pAmount = 45
    if (self.potion_stock[self.currentPotion] == 0) then
        print(" t'as plus de potions frérot !")
    elseif self.currentPotion == 1 then
        self.potion_stock[1] = self.potion_stock[1] - 1
        -- on s'assure qu'il ne peut pas regen plus que sa vie max
        if self.currentHealth +  pAmount > self.maxHealth then
            self.targetHealth = self.maxHealth
        else
            self.targetHealth =self.targetHealth + pAmount
        end
    elseif self.currentPotion == 2 and not self.timer1 then
        self:consume()
    elseif self.currentPotion == 3 and not self.timer2 then
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

function Player:castSpell()
    if self.currentEnergy > 9.9 then
        self.currentEnergy = 0
        self.energyTimer = Timer:new(0.1)
        local p = {}
        local direction_step = 10

        for i=0, 360 - direction_step, direction_step do
            p = Projectile:new()
            if self.flipH == 1 then
                p:init(i, 5, "bullet", self.pos + Vector:new(4, -2), G_fireballSC, G_fireballHF)
            elseif self.flipH == -1 then
                p:init(i, 5, "bullet", self.pos + Vector:new(-4, -2), G_fireballSC, G_fireballHF)
            end
        end
    end
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

function Player:energyUpdate(dt)
    if self.energyTimer and self.energyTimer:update(dt) then
        self.energyTimer = nil
        if self.currentEnergy < 9.9 then
            -- self.currentEnergy = self.currentEnergy + 0.01
            self.currentEnergy = self.currentEnergy + 0.1
           -- self.skillAngleCd  = self.skillAngleCd + 360/100
            self.energyTimer = Timer:new(0.01)
        end
    end
end

return Player