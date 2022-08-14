local Entity = require("entity/entity")
local Projectile = require("entity/projectile")
local Score = require("score")
local Data = require("data")

--- Class representing the Player.
--- @class Player:Entity Player is a subclass of Entity.
--- @field new fun(self:Player): Player
--- @field inventory table
--- @field collectRadius number
Player = Entity:new()

--- Initializes the item.
--- @param inventory Item[]|Weapon[]|Consumable[]|Coin[]
--- @param collectRadius number
function Player:init(inventory, collectRadius, ...)
    self.inventory = inventory or {}
    self.maxEnergy = 1000
    self.currentEnergy = 0
   -- self.skillAngleCd = 0 or 0
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

    --speed potion animation
    self.trail1 = nil
    self.trail2 = nil
    self.trailTimer = Timer:new(0.1)


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
            self:move(move, dt)
        else
            if self.state == "run" then self:changeState("idle") end
        end
    end

    local currentFrame, animationFinished = self.spriteTimer:update(dt, self.spriteCollection:getSpriteFramesDuration(self.state), self.spriteCollection:getNumberOfSprites(self.state))

    -- attack handling
    if #self.inventory > 0 then
        if self.state == "attack" then
            if currentFrame >= 4 and not self.hasShoot then
                if G_soundEffectsOn then
                    local sound = love.audio.newSource("sound/soundeffects/player_attack.wav", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
                    sound:setVolume(0.5)
                    sound:play()
                end
                self.hasShoot = true
                local p = Projectile:new()
                local direction = Vector:new(self.flipH, 0)

                if self.flipH == 1 then
                    p:init(self.damage, direction, 5, "bullet", self.pos + Vector:new(9, 5), Data.fireballSC, Data.fireballHF)
                elseif self.flipH == -1 then
                    p:init(self.damage, direction, 5, "bullet", self.pos + Vector:new(-9, 5), Data.fireballSC, Data.fireballHF)
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
                G_blackoutOnPlayer = false -- For safety, in case a frame is skipped.
            elseif currentFrame == 2 and not G_blackoutSFX then
                if G_soundEffectsOn then
                    local sound
                    if G_gandalf then
                        sound = love.audio.newSource("sound/soundeffects/ysnp.mp3", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
                        sound:setVolume(1)
                    else
                        sound = love.audio.newSource("sound/soundeffects/special_attack_cling.wav", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
                        sound:setVolume(0.4)
                    end
                    sound:play()
                end
                G_blackoutSFX = true
            elseif currentFrame == 3 then -- Not 1 because when the animation is finished it is in frame 1
                G_blackoutOnPlayer = true
                G_blackoutSFX = false
            elseif currentFrame >= 7 then
                G_blackoutCurrentFrame = 125
                if not self.hasShoot then
                    self:castSpell()
                    self.hasShoot = true
                end
                if currentFrame >= 9 then
                    G_blackoutOnPlayer = false
                end
            end
        end
    end

    if self.buffs[2] > 0 then
        if self.state == "idle" then
            self.trail2 = self.pos
            self.trail1 = self.pos
        end
        if (self.state == "run" or self.state == "attack") and self.trailTimer:update(dt) then
            self.trail2 = self.trail1
            self.trail1 = self.pos
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

    if #self.inventory == 0 then
        if self.state == "idle" then
            Entity.draw(self, "idleEmpty")
        elseif self.state == "run" then
            Entity.draw(self, "idleEmpty")
        else
            Entity.draw(self)
        end
    else
        Entity.draw(self)

        if self.buffs[2] > 0 and (self.state == "run" or self.state == "attack") then
            local previous_r, previous_g, previous_b, previous_a = love.graphics.getColor()
            love.graphics.setColor(previous_r, previous_g, previous_b, 0.5)
            self.spriteCollection:draw(self.state, self.trail1, self.spriteTimer:getCurrentFrame(), self.flipH, self.flipV, self.angle)
            love.graphics.setColor(previous_r, previous_g, previous_b, 0.25)
            self.spriteCollection:draw(self.state, self.trail2, self.spriteTimer:getCurrentFrame(), self.flipH, self.flipV, self.angle)
            love.graphics.setColor(previous_r, previous_g, previous_b, previous_a)
        end
    end

    -- if self.buffs > 2
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
            if G_soundEffectsOn then
                coinSound:setVolume(0.3)
                coinSound:play()
            end
        --potions
        elseif tostring(item)=="Consumable" then
            if G_soundEffectsOn then
                itemSound:setVolume(0.3)
                itemSound:play()
            end
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
            if G_soundEffectsOn then
                itemSound:setVolume(0.3)
                itemSound:play()
            end
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
        if G_soundEffectsOn then
            local sound = love.audio.newSource("sound/soundeffects/potion_drink.wav", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
            sound:setVolume(0.5)
            sound:play()
        end
        self.potion_stock[1] = self.potion_stock[1] - 1
        -- on s'assure qu'il ne peut pas regen plus que sa vie max
        if self.currentHealth +  pAmount > self.maxHealth then
            self.targetHealth = self.maxHealth
        else
            self.targetHealth =self.targetHealth + pAmount
        end
    elseif self.currentPotion == 2 and not self.timer1 then
        if G_soundEffectsOn then
            local sound = love.audio.newSource("sound/soundeffects/potion_drink.wav", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
            sound:setVolume(0.5)
            sound:play()
        end
        self:consume()
    elseif self.currentPotion == 3 and not self.timer2 then
        if G_soundEffectsOn then
            local sound = love.audio.newSource("sound/soundeffects/potion_drink.wav", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
            sound:setVolume(0.5)
            sound:play()
        end
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
        self.trail1 = self.pos
        self.trail2 = self.pos
    end

end

function Player:castSpell()
    if self.currentEnergy > 990 and #self.inventory > 0 and not self.hasShoot then
        if G_soundEffectsOn then
            local sound=love.audio.newSource("sound/soundeffects/special_attack.wav","static")
            sound:setVolume(0.5)
            sound:play()
        end
        self.currentEnergy = 0
        self.energyTimer = Timer:new(0.1)
        local p = {}
        local direction_step = 10

        for i=0, 360 - direction_step, direction_step do
            p = Projectile:new()
            if self.flipH == 1 then
                p:init(self.damage, i, 5, "bullet", self.pos + Vector:new(4, -2), Data.fireballSC, Data.fireballHF)
            elseif self.flipH == -1 then
                p:init(self.damage, i, 5, "bullet", self.pos + Vector:new(-4, -2), Data.fireballSC, Data.fireballHF)
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
    if self.currentEnergy < 1000 then
        self.currentEnergy = math.min(math.floor(self.currentEnergy + 2 * 60 * dt), 1000)
    end
end

return Player