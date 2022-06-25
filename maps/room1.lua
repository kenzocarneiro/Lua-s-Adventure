--MONSTERS
local troll_sc = SpriteCollection:new("troll")
troll_sc:init({Sprite:new("img/troll_idle-Sheet.png", true, "idle", 16, 16, Vector:new(7, 6)),
    Sprite:new("img/troll_run-Sheet.png", true, "run", 16, 16, Vector:new(7, 6), false, {0.12, 0.12, 0.12, 0.12})})

local rhino_sc = SpriteCollection:new("rhino")
rhino_sc:init({Sprite:new("img/rhino_idle-Sheet.png", true, "idle", 16, 16, Vector:new(6, 13)),
    Sprite:new("img/rhino_run-Sheet.png", true, "run", 16, 16, Vector:new(6, 13))})

local trollHF = HitboxFactory:new(
    {name="hitbox", layers={enemy=true}, width=5, height=11, offset=Vector:new(-2, -2)},
    {name="hurtbox", layers={player=true}, width=7, height=13, offset=Vector:new(-3, -3)}
)

local rhinoHF = HitboxFactory:new(
    {name="hitbox", layers={enemy=true}, width=4, height=7, offset=Vector:new(-2, -6)},
    {name="hurtbox", layers={player=true}, width=6, height=9, offset=Vector:new(-3, -7)}
)

--STAFFS
local cool_staff_sc = SpriteCollection:new("item")
cool_staff_sc:init({Sprite:new("img/magic_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

local cool_staffHF = HitboxFactory:new(
    {"hitbox", {item=true}, 3, 14, Vector:new(-5, -5)}
)

local simple_staff_sc = SpriteCollection:new("item")
simple_staff_sc:init({Sprite:new("img/simple_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

local simple_staffHF = HitboxFactory:new(
    {"hitbox", {item=true}, 3, 10, Vector:new(-6, -5)}
)

local gold_staff_sc = SpriteCollection:new("item")
gold_staff_sc:init({Sprite:new("img/gold_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

local gold_staffHF = HitboxFactory:new(
    {"hitbox", {item=true}, 3, 14, Vector:new(-5, -5)}
)

local power_staff_sc = SpriteCollection:new("item")
power_staff_sc:init({Sprite:new("img/power_staff.png", false, "idle", 16, 16, Vector:new(7, 6))})

local power_staffHF = HitboxFactory:new(
    {"hitbox", {item=true}, 3, 13, Vector:new(-5, -4)}
)

--POTIONS
local bluePotionSc = SpriteCollection:new("consumable")
bluePotionSc:init({Sprite:new("img/potion_blue.png", false, "idle", 16, 16, Vector:new(7, 6))})

local redPotionSc = SpriteCollection:new("consumable")
redPotionSc:init({Sprite:new("img/potion_red.png", false, "idle", 16, 16, Vector:new(7, 6))})

local yellowPotionSc = SpriteCollection:new("consumable")
yellowPotionSc:init({Sprite:new("img/potion_yellow.png", false, "idle", 16, 16, Vector:new(7, 6))})

local coinSc = SpriteCollection:new("coin")
coinSc:init({Sprite:new("img/coin.png", false, "idle", 16, 16, Vector:new(7, 6))})

local troll = Monster:new()
    troll:init("troll", 80, "advanced", 0.5, 0.3, "epee", Vector:new(70, 80), troll_sc, trollHF)

    local rhino = Monster:new()
    rhino:init("rhino", 50, "simple", 0.5, 0.5, "epee", Vector:new(150, 150), rhino_sc, rhinoHF)


    local speedPotion = Consumable:new()
    speedPotion:init("speed", 0.5, "potion of speed", Vector:new(250, 150), bluePotionSc)
    local healthPotion = Consumable:new()
    healthPotion:init("health", 1, "potion of heatlh", Vector:new(30, 150), redPotionSc)

    local damagePotion = Consumable:new()
    damagePotion:init("damage", 1, "potion of health", Vector:new(30, 50), yellowPotionSc)

    local goldCoin = Coin:new()
    goldCoin:init(3, "coin of gold", Vector:new(200, 20), coinSc)

    local simple_staff = Weapon:new()
    simple_staff:init(1, "The simple staff", Vector:new(90, 70), simple_staff_sc, simple_staffHF)

    local cool_staff = Weapon:new()
    cool_staff:init(2, "The cooler staff", Vector:new(200, 90), cool_staff_sc, cool_staffHF)

    local power_staff = Weapon:new()
    power_staff:init(5, "The powerful staff", Vector:new(80, 40), power_staff_sc, power_staffHF)

    local gold_staff = Weapon:new()
    gold_staff:init(10, "You achieved capitalism", Vector:new(250, 40), gold_staff_sc, gold_staffHF)

return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 38,
  height = 20,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 3,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "topdown",
      firstgid = 1,
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "../microFantasy.v0.4/tilesets/topdown.png",
      imagewidth = 64,
      imageheight = 64,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 8,
        height = 8
      },
      properties = {},
      wangsets = {},
      tilecount = 64,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 38,
      height = 20,
      id = 2,
      name = "Ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        52, 35, 44, 28, 44, 49, 53, 37, 35, 34, 27, 51, 34, 43, 49, 33, 52, 35, 44, 28, 44, 49, 53, 37, 35, 34, 27, 51, 34, 43, 49, 33, 25, 25, 25, 25, 25, 25,
        49, 35, 28, 25, 52, 26, 28, 26, 41, 25, 34, 36, 53, 35, 28, 37, 49, 35, 28, 25, 52, 26, 28, 26, 41, 25, 34, 36, 53, 35, 28, 37, 34, 53, 53, 34, 29, 43,
        43, 45, 53, 43, 34, 29, 35, 25, 50, 49, 25, 45, 42, 35, 41, 33, 43, 45, 53, 43, 34, 29, 35, 25, 50, 49, 25, 45, 42, 35, 41, 33, 50, 27, 35, 42, 28, 53,
        43, 34, 50, 53, 50, 50, 29, 45, 34, 51, 53, 27, 45, 25, 26, 27, 43, 34, 50, 53, 50, 50, 29, 45, 34, 51, 53, 27, 45, 25, 26, 27, 43, 49, 29, 36, 26, 27,
        26, 25, 52, 50, 42, 45, 44, 53, 34, 29, 35, 36, 34, 34, 37, 49, 26, 25, 52, 50, 42, 45, 44, 53, 34, 29, 35, 36, 34, 34, 37, 49, 37, 26, 53, 33, 45, 36,
        51, 27, 49, 37, 52, 33, 43, 33, 52, 35, 42, 27, 35, 43, 44, 51, 51, 27, 49, 37, 52, 33, 43, 33, 52, 35, 42, 27, 35, 43, 44, 51, 53, 36, 49, 26, 41, 49,
        50, 44, 36, 51, 36, 44, 42, 50, 25, 45, 42, 34, 50, 41, 29, 50, 50, 44, 36, 51, 36, 44, 42, 50, 25, 45, 42, 34, 50, 41, 29, 50, 26, 25, 35, 28, 41, 49,
        33, 36, 51, 29, 26, 28, 52, 53, 33, 42, 37, 36, 53, 29, 52, 51, 33, 36, 51, 29, 26, 28, 52, 53, 33, 42, 37, 36, 53, 29, 52, 51, 34, 41, 43, 36, 42, 37,
        43, 35, 27, 27, 45, 34, 35, 35, 45, 41, 51, 51, 45, 53, 50, 42, 43, 35, 27, 27, 45, 34, 35, 35, 45, 41, 51, 51, 45, 53, 50, 42, 49, 36, 37, 25, 35, 51,
        25, 28, 35, 34, 45, 37, 34, 34, 36, 35, 35, 25, 36, 53, 53, 37, 25, 28, 35, 34, 45, 37, 34, 34, 36, 35, 35, 25, 36, 53, 53, 25, 45, 27, 51, 36, 50, 53,
        52, 35, 44, 28, 44, 49, 53, 37, 35, 34, 27, 51, 34, 43, 49, 33, 52, 35, 44, 28, 44, 49, 53, 37, 35, 34, 27, 51, 34, 43, 49, 29, 28, 42, 50, 34, 26, 28,
        49, 35, 28, 25, 52, 26, 28, 26, 41, 25, 34, 36, 53, 35, 28, 37, 49, 35, 28, 25, 52, 26, 28, 26, 41, 25, 34, 36, 53, 35, 28, 37, 50, 27, 29, 34, 28, 51,
        43, 45, 53, 43, 34, 29, 35, 25, 50, 49, 25, 45, 42, 35, 41, 33, 43, 45, 53, 43, 34, 29, 35, 25, 50, 49, 25, 45, 42, 35, 41, 33, 42, 52, 35, 41, 53, 34,
        43, 34, 50, 53, 50, 50, 29, 45, 34, 51, 53, 27, 45, 25, 26, 27, 43, 34, 50, 53, 50, 50, 29, 45, 34, 51, 53, 27, 45, 25, 26, 27, 51, 51, 53, 25, 27, 50,
        26, 25, 52, 50, 42, 45, 44, 53, 34, 29, 35, 36, 34, 34, 37, 49, 26, 25, 52, 50, 42, 45, 44, 53, 34, 29, 35, 36, 34, 34, 37, 49, 51, 43, 44, 42, 28, 49,
        51, 27, 49, 37, 52, 33, 43, 33, 52, 35, 42, 27, 35, 43, 44, 51, 51, 27, 49, 37, 52, 33, 43, 33, 52, 35, 42, 27, 35, 43, 44, 51, 35, 36, 25, 50, 45, 25,
        50, 44, 36, 51, 36, 44, 42, 50, 25, 45, 42, 34, 50, 41, 29, 50, 50, 44, 36, 51, 36, 44, 42, 50, 25, 45, 42, 34, 50, 41, 29, 50, 42, 43, 50, 25, 37, 33,
        33, 36, 51, 29, 26, 28, 52, 53, 33, 42, 37, 36, 53, 29, 52, 51, 33, 36, 51, 29, 26, 28, 52, 53, 33, 42, 37, 36, 53, 29, 52, 51, 43, 34, 34, 49, 45, 36,
        43, 35, 27, 27, 45, 34, 35, 35, 45, 41, 51, 51, 45, 53, 50, 42, 43, 35, 27, 27, 45, 34, 35, 35, 45, 41, 51, 51, 45, 53, 50, 42, 33, 43, 35, 43, 28, 52,
        25, 28, 35, 34, 45, 37, 34, 34, 36, 35, 35, 25, 36, 53, 53, 37, 25, 28, 35, 34, 45, 37, 34, 34, 36, 35, 35, 25, 36, 53, 53, 37, 35, 51, 27, 33, 33, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 38,
      height = 20,
      id = 1,
      name = "Walls",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        13, 2, 2, 2, 2, 2, 2, 6, 2, 2, 2, 2, 2, 2, 2, 5, 6, 2, 2, 2, 2, 2, 2, 2, 2, 2, 5, 6, 2, 2, 2, 2, 2, 2, 2, 2, 2, 14,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 5, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        21, 2, 2, 5, 6, 2, 2, 2, 2, 2, 2, 5, 2, 2, 2, 22, 21, 2, 2, 5, 6, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 5, 2, 2, 2, 2, 2, 22
      }
    }
  }
}
