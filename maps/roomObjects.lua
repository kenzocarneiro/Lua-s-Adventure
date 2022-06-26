RoomObjects = {}

local D = require("data")

function RoomObjects.createObjects(roomNbr)
    --- Room 0 ---
    if roomNbr == 0 then
        local cool_staff = Weapon:new()
        cool_staff:init(2, "The cooler staff", Vector:new(200, 80), D.cool_staffSC, D.cool_staffHF)



    --- Room 1 ---
    elseif roomNbr == 1 then
        -- -- Elements interactibles
        -- local fire_pillarSC = SpriteCollection:new("fire_pillar")
        -- fire_pillarSC:init({Sprite:new("img/hud/fire_pillar_off.png", true, "off", 16, 16, Vector:new(7, 6)),
        --     Sprite:new("img/hud/fire_pillar_on.png", true, "on", 16, 16, Vector:new(7, 6), false, {0.12, 0.12, 0.12, 0.12})})

        --   local fire_pillar = HitboxFactory:new(
        --     {name="hitbox", layers={enemy=true}, width=5, height=11, offset=Vector:new(-2, -2)},
        --     {name="hurtbox", layers={player=false}, width=7, height=13, offset=Vector:new(-3, -3)}
        -- )


        -- local firePillar = Element:new()
        --     firePillar:init(Vector:new(150,150), fire_pillarSC, fire_pillar)

        local speedPotion = Consumable:new()
        speedPotion:init("speed", 0.5, "potion of speed", Vector:new(250, 150), D.bluePotionSc)
        local healthPotion = Consumable:new()
        healthPotion:init("health", 1, "potion of heatlh", Vector:new(30, 150), D.redPotionSc)

        local damagePotion = Consumable:new()
        damagePotion:init("damage", 1, "potion of damage", Vector:new(30, 50), D.yellowPotionSc)

        local goldCoin = Coin:new()
        goldCoin:init(3, "coin of gold", Vector:new(200, 20), D.coinSc)

        local simple_staff = Weapon:new()
        simple_staff:init(1, "The simple staff", Vector:new(90, 70), D.simple_staffSC, D.simple_staffHF)

        local cool_staff = Weapon:new()
        cool_staff:init(2, "The cooler staff", Vector:new(200, 90), D.cool_staffSC, D.cool_staffHF)

        local power_staff = Weapon:new()
        power_staff:init(5, "The powerful staff", Vector:new(80, 40), D.power_staffSC, D.power_staffHF)

        local gold_staff = Weapon:new()
        gold_staff:init(10, "You achieved capitalism", Vector:new(250, 40), D.gold_staffSC, D.gold_staffHF)

        local troll = Monster:new()
        troll:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {0.5, "simple_staff", D.simple_staffSC, D.simple_staffHF},
        {0.8, "coin", D.coinSc}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(70, 80), D.trollSC, D.trollHF)

        local rhino = Monster:new()
        rhino:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {1, "healthPotion", D.redPotionSc}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(150, 150), D.rhinoSC, D.rhinoHF)



    --- Room 2 ---
    elseif roomNbr == 2 then
        --addind everything we want on map (monsters and items)

        --INITIALISATION OF MONSTERS AND ITEMS
        -- local rhino = Monster:new()
        -- rhino:init("rhino", 50, "simple", 0.5, 0.5, "epee", Vector:new(88, 40), D.rhinoSC, D.rhinoHF)



    --- Room 3 ---
    elseif roomNbr == 3 then
        local damagePotion = Consumable:new()
        damagePotion:init("damage", 1, "potion of damage", Vector:new(48, 24), D.yellowPotionSc)

        local goldCoin = Coin:new()
        goldCoin:init(3, "coin of gold", Vector:new(32, 134), D.coinSc)

        local goldCoin2 = Coin:new()
        goldCoin2:init(3, "coin of gold", Vector:new(260, 140), D.coinSc)

        local goldCoin3 = Coin:new()
        goldCoin3:init(3, "coin of gold", Vector:new(280, 140), D.coinSc)

        local simple_staff = Weapon:new()
        simple_staff:init(1, "The simple staff", Vector:new(190, 120), D.simple_staffSC, D.simple_staffHF)

        local troll = Monster:new()
        troll:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {0.5, "simple_staff", D.simple_staffSC, D.simple_staffHF},
        {0.8, "coin", D.coinSc}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(120, 24), D.trollSC, D.trollHF)

        local troll2 = Monster:new()
        troll2:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {0.5, "simple_staff", D.simple_staffSC, D.simple_staffHF},
        {0.8, "coin", D.coinSc}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(120, 145), D.trollSC, D.trollHF)

        local troll3 = Monster:new()
        troll3:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {0.5, "simple_staff", D.simple_staffSC, D.simple_staffHF},
        {0.8, "coin", D.coinSc}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(184, 145), D.trollSC, D.trollHF)

        local troll4 = Monster:new()
        troll4:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {0.5, "simple_staff", D.simple_staffSC, D.simple_staffHF},
        {0.8, "coin", D.coinSc}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(184, 24), D.trollSC, D.trollHF)

        local rhino = Monster:new()
        rhino:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {1, "healthPotion", D.redPotionSc}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(56, 34), D.rhinoSC, D.rhinoHF)

        local rhino3 = Monster:new()
        rhino3:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {1, "healthPotion", D.redPotionSc}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(40, 34), D.rhinoSC, D.rhinoHF)

        local rhino2 = Monster:new()
        rhino2:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {1, "healthPotion", D.redPotionSc}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(264, 80), D.rhinoSC, D.rhinoHF)
    end
end


return RoomObjects