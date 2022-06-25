
local d = require("data")

local goldCoin = Coin:new()
goldCoin:init(3, "coin of gold", Vector:new(32, 134), d.coinSc)

local goldCoin2 = Coin:new()
goldCoin2:init(3, "coin of gold", Vector:new(260, 140), d.coinSc)

local goldCoin3 = Coin:new()
goldCoin3:init(3, "coin of gold", Vector:new(280, 140), d.coinSc)

local cool_staff = Weapon:new()
cool_staff:init(2, "The cooler staff", Vector:new(176, 104), d.cool_staff_sc, d.cool_staffHF)


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


local troll = Monster:new()
troll:init({{0.1, "gold_staff", d.gold_staff_sc, d.gold_staffHF}, {0.5, "simple_staff", d.simple_staff_sc, d.simple_staffHF},
{0.8, "coin", d.coinSc}},
"troll", 80, "advanced", 0.3, "epee", Vector:new(120, 24), d.troll_sc, d.trollHF)

local troll2 = Monster:new()
troll2:init({{0.1, "gold_staff", gold_staff_sc, gold_staffHF}, {0.5, "simple_staff", simple_staff_sc, simple_staffHF},
{0.8, "coin", d.coinSc}},
"troll", 80, "advanced", 0.3, "epee", Vector:new(120, 145), d.troll_sc, d.trollHF)

local troll3 = Monster:new()
troll3:init({{0.1, "gold_staff", gold_staff_sc, gold_staffHF}, {0.5, "simple_staff", simple_staff_sc, simple_staffHF},
{0.8, "coin", d.coinSc}},
"troll", 80, "advanced", 0.3, "epee", Vector:new(184, 145), d.troll_sc, d.trollHF)

local troll4 = Monster:new()
troll4:init({{0.1, "gold_staff", gold_staff_sc, gold_staffHF}, {0.5, "simple_staff", simple_staff_sc, simple_staffHF},
{0.8, "coin", d.coinSc}},
"troll", 80, "advanced", 0.3, "epee", Vector:new(184, 24), d.troll_sc, d.trollHF)

local rhino = Monster:new()
rhino:init({{0.1, "gold_staff", gold_staff_sc, gold_staffHF}, {1, "healthPotion", d.redPotionSc}},
"rhino", 50, "simple", 0.5, "epee", Vector:new(56, 34), d.rhino_sc, d.rhinoHF)

local rhino3 = Monster:new()
rhino3:init({{0.1, "gold_staff", gold_staff_sc, gold_staffHF}, {1, "healthPotion", d.redPotionSc}},
"rhino", 50, "simple", 0.5, "epee", Vector:new(40, 34), d.rhino_sc, d.rhinoHF)

local rhino2 = Monster:new()
rhino2:init({{0.1, "gold_staff", gold_staff_sc, gold_staffHF}, {1, "healthPotion", d.redPotionSc}},
"rhino", 50, "simple", 0.5, "epee", Vector:new(264, 80), d.rhino_sc, d.rhinoHF)


return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.6",
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
      name = "dungeon_topdown",
      firstgid = 1,
      filename = "../dungeon_topdown.tsx"
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
      name = "Calque de Tuiles 2",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 26, 27, 28, 28, 28, 28, 28, 28, 27, 28, 25, 25, 25, 25, 25, 25,
        25, 26, 27, 26, 34, 35, 36, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 37,
        33, 34, 34, 35, 36, 35, 36, 35, 36, 33, 34, 35, 36, 37, 25, 25, 25, 34, 34, 34, 34, 34, 34, 34, 35, 36, 25, 25, 25, 51, 51, 25, 25, 51, 51, 51, 51, 45,
        33, 34, 34, 35, 36, 35, 36, 43, 34, 35, 36, 43, 44, 45, 25, 34, 34, 42, 42, 42, 42, 42, 42, 34, 35, 34, 34, 34, 35, 36, 51, 34, 35, 36, 25, 51, 51, 45,
        33, 34, 34, 35, 36, 35, 36, 36, 34, 34, 35, 36, 34, 34, 34, 34, 42, 42, 43, 44, 28, 34, 35, 34, 35, 42, 42, 34, 34, 35, 36, 34, 35, 36, 34, 35, 36, 45,
        33, 34, 42, 43, 44, 43, 44, 36, 42, 34, 35, 34, 35, 34, 42, 34, 42, 43, 44, 36, 36, 34, 35, 34, 35, 42, 43, 42, 34, 34, 35, 34, 35, 36, 34, 35, 36, 45,
        33, 34, 35, 34, 35, 36, 35, 36, 36, 34, 34, 42, 43, 34, 35, 42, 42, 43, 44, 44, 44, 36, 35, 42, 34, 42, 43, 44, 42, 34, 35, 34, 35, 36, 34, 35, 36, 36,
        33, 34, 35, 34, 35, 36, 35, 36, 44, 34, 42, 42, 43, 34, 34, 35, 34, 42, 43, 44, 43, 44, 35, 36, 34, 42, 43, 44, 34, 35, 36, 34, 35, 34, 35, 36, 36, 44,
        33, 34, 35, 34, 35, 36, 35, 36, 52, 42, 42, 43, 44, 42, 34, 35, 34, 42, 43, 44, 43, 44, 35, 36, 34, 42, 43, 44, 34, 35, 36, 34, 35, 34, 35, 36, 44, 44,
        33, 34, 35, 34, 35, 36, 35, 36, 34, 34, 42, 43, 44, 36, 34, 35, 42, 42, 43, 44, 43, 44, 35, 36, 42, 42, 43, 44, 34, 35, 36, 34, 35, 34, 35, 36, 43, 44,
        33, 34, 35, 34, 35, 36, 43, 44, 34, 34, 34, 42, 43, 34, 35, 36, 36, 42, 43, 44, 43, 44, 34, 35, 36, 42, 43, 44, 34, 35, 36, 34, 35, 34, 35, 36, 42, 43,
        33, 34, 34, 42, 43, 44, 53, 34, 41, 34, 34, 42, 43, 42, 43, 44, 36, 42, 43, 44, 44, 42, 34, 35, 36, 42, 43, 44, 42, 43, 44, 34, 35, 34, 35, 36, 43, 44,
        34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 35, 34, 42, 43, 44, 35, 42, 43, 44, 44, 25, 34, 35, 36, 42, 43, 44, 36, 25, 25, 34, 35, 34, 35, 36, 43, 44,
        33, 53, 42, 43, 44, 44, 41, 34, 34, 42, 34, 35, 42, 42, 43, 44, 43, 42, 43, 44, 44, 36, 34, 35, 36, 42, 43, 44, 44, 25, 25, 34, 35, 42, 43, 44, 44, 45,
        33, 53, 42, 43, 44, 25, 41, 25, 34, 34, 34, 35, 42, 43, 44, 44, 44, 42, 43, 44, 44, 44, 34, 35, 36, 37, 42, 43, 44, 28, 51, 34, 34, 42, 43, 44, 25, 45,
        33, 41, 42, 43, 44, 41, 25, 25, 25, 53, 34, 34, 42, 43, 44, 43, 44, 44, 43, 42, 43, 44, 36, 35, 36, 28, 42, 43, 44, 51, 25, 42, 42, 42, 43, 44, 25, 45,
        33, 41, 42, 43, 44, 25, 25, 25, 25, 53, 42, 42, 42, 43, 44, 25, 51, 43, 43, 25, 42, 43, 44, 36, 36, 51, 51, 25, 25, 25, 25, 42, 43, 44, 25, 25, 25, 45,
        33, 53, 42, 43, 44, 25, 25, 25, 25, 25, 25, 25, 51, 25, 43, 43, 51, 25, 25, 25, 42, 43, 44, 44, 44, 51, 51, 51, 51, 25, 25, 25, 25, 25, 25, 25, 25, 45,
        41, 53, 25, 25, 53, 53, 53, 53, 53, 53, 53, 25, 51, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 45,
        25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 53, 53, 51, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 38,
      height = 20,
      id = 1,
      name = "Calque de Tuiles 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        13, 2, 2, 2, 2, 2, 2, 2, 2, 14, 2, 2, 5, 5, 2, 2, 2, 2, 2, 5, 6, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 14,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 13, 2, 2, 14, 0, 0, 0, 0, 13, 2, 2, 14, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 12, 31, 31, 11, 0, 0, 0, 0, 12, 31, 31, 11, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        13, 2, 2, 2, 2, 2, 5, 0, 6, 14, 0, 0, 0, 12, 0, 0, 11, 0, 0, 0, 0, 12, 0, 0, 11, 0, 0, 0, 13, 5, 0, 6, 2, 2, 2, 2, 2, 14,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 21, 2, 2, 22, 0, 0, 0, 0, 21, 2, 2, 22, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        18, 0, 0, 0, 0, 0, 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 13, 2, 2, 14, 0, 0, 0, 0, 13, 2, 2, 14, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        13, 2, 2, 2, 2, 2, 5, 0, 6, 14, 0, 0, 0, 12, 31, 31, 11, 0, 0, 0, 0, 12, 0, 0, 11, 0, 0, 0, 13, 2, 0, 2, 2, 2, 2, 2, 2, 14,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 12, 0, 0, 11, 0, 0, 0, 0, 12, 0, 0, 11, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        18, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 21, 2, 2, 22, 0, 0, 0, 0, 21, 5, 0, 22, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        18, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 11,
        21, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 22
      }
    }
  }
}
