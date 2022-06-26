local data = {}

Vector = require("vector")
Sprite = require("sprite/sprite")
SpriteCollection = require("sprite/spriteC")
HitboxFactory = require("hitboxF")
Consumable = require("item/consumable")
Coin = require("item/coin")
Weapon = require("item/weapon")
Item = require("item/item")
Monster = require("entity/monster")


-- THE PLAYER

--initialize sprite collections
data.playerSC = SpriteCollection:new("player")
data.playerSC:init({Sprite:new("img/wizard_idle-Sheet0.png", true, "idleEmpty", 18, 18, Vector:new(7, 9), false, {0.5, 0.1, 0.06, 0.1, 0.1, 0.1}),
    Sprite:new("img/wizard_run-Sheet0.png", true, "runEmpty", 18, 18, Vector:new(7, 9), false),
    Sprite:new("img/wizard_idle-Sheet.png", true, "idle", 18, 18, Vector:new(7, 9), false, {0.5, 0.1, 0.06, 0.1, 0.1, 0.1}),
    Sprite:new("img/wizard_run-Sheet.png", true, "run", 18, 18, Vector:new(7, 9), false),
    Sprite:new("img/wizard_attack-Sheet.png", true, "attack", 18, 18, Vector:new(7, 9)),
    Sprite:new("img/wizard_special-Sheet.png", true, "special", 18, 18, Vector:new(7, 9), false, {0.5, 0.05, 0.25, 0.25, 0.25, 0.25, 0.06, 0.1, 0.1, 0.1})
})

data.playerHF = HitboxFactory:new(
    -- {"hurtbox", {enemy=true}, 5, 5, Vector:new(-5, -5)},
    {"hitbox", {player=true}, 4, 10, Vector:new(-2, -2)}
)

-- OTHERS
data.fireballSC = SpriteCollection:new("fireball")
data.fireballSC:init({Sprite:new("img/fireball-Sheet.png", true, "idle", 10, 7, Vector:new(8, 4))})
data.fireballHF = HitboxFactory:new({"hurtbox", {enemy=true}, 3, 3, Vector:new(-2, -2)})

-- MONSTERS
data.trollSC = SpriteCollection:new("troll")
data.trollSC:init({Sprite:new("img/troll_idle-Sheet.png", true, "idle", 16, 16, Vector:new(7, 6)),
    Sprite:new("img/troll_run-Sheet.png", true, "run", 16, 16, Vector:new(7, 6), false, {0.12, 0.12, 0.12, 0.12})})

data.rhinoSC = SpriteCollection:new("rhino")
data.rhinoSC:init({Sprite:new("img/rhino_idle-Sheet.png", true, "idle", 16, 16, Vector:new(6, 13)),
    Sprite:new("img/rhino_run-Sheet.png", true, "run", 16, 16, Vector:new(6, 13))})

data.trollHF = HitboxFactory:new(
    {name="hitbox", layers={enemy=true}, width=5, height=11, offset=Vector:new(-2, -2)},
    {name="hurtbox", layers={player=true}, width=7, height=13, offset=Vector:new(-3, -3)}
)

data.rhinoHF = HitboxFactory:new(
    {name="hitbox", layers={enemy=true}, width=4, height=7, offset=Vector:new(-2, -6)},
    {name="hurtbox", layers={player=true}, width=6, height=9, offset=Vector:new(-3, -7)}
)

-- STAFFS
data.cool_staffSC = SpriteCollection:new("item")
data.cool_staffSC:init({Sprite:new("img/magic_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

data.cool_staffHF = HitboxFactory:new(
    {"hitbox", {item=true}, 3, 14, Vector:new(-5, -5)}
)

data.simple_staffSC = SpriteCollection:new("item")
data.simple_staffSC:init({Sprite:new("img/simple_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

data.simple_staffHF = HitboxFactory:new(
    {"hitbox", {item=true}, 3, 10, Vector:new(-6, -5)}
)

data.gold_staffSC = SpriteCollection:new("item")
data.gold_staffSC:init({Sprite:new("img/gold_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

data.gold_staffHF = HitboxFactory:new(
    {"hitbox", {item=true}, 3, 14, Vector:new(-5, -5)}
)

data.power_staffSC = SpriteCollection:new("item")
data.power_staffSC:init({Sprite:new("img/power_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

data.power_staffHF = HitboxFactory:new(
    {"hitbox", {item=true}, 3, 13, Vector:new(-5, -4)}
)

-- POTIONS
data.bluePotionSc = SpriteCollection:new("consumable")
data.bluePotionSc:init({Sprite:new("img/potion_blue.png", false, "idle", 16, 16, Vector:new(7, 6))})

data.redPotionSc = SpriteCollection:new("consumable")
data.redPotionSc:init({Sprite:new("img/potion_red.png", false, "idle", 16, 16, Vector:new(7, 6))})

data.yellowPotionSc = SpriteCollection:new("consumable")
data.yellowPotionSc:init({Sprite:new("img/potion_yellow.png", false, "idle", 16, 16, Vector:new(7, 6))})

data.coinSc = SpriteCollection:new("coin")
data.coinSc:init({Sprite:new("img/coin.png", false, "idle", 16, 16, Vector:new(7, 6))})

return data