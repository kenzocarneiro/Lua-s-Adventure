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

        -- local healthPotion = Consumable:new()
        -- healthPotion:init("health", 1, "potion of heatlh", Vector:new(200, 50), D.redPotionSC)
        local damagePotion = Consumable:new()
        damagePotion:init("damage", 1, "potion of damage", Vector:new(300, 100), D.yellowPotionSC)
        local speedPotion = Consumable:new()
        speedPotion:init("speed", 0.5, "potion of speed", Vector:new(200, 150), D.bluePotionSC)

        local goldCoin = Coin:new()
        goldCoin:init(3, "coin of gold", Vector:new(290, 100), D.coinSC)
        local goldCoin = Coin:new()
        goldCoin:init(3, "coin of gold", Vector:new(280, 100), D.coinSC)
        local goldCoin = Coin:new()
        goldCoin:init(3, "coin of gold", Vector:new(270, 100), D.coinSC)

        -- local simple_staff = Weapon:new()
        -- simple_staff:init(1, "The simple staff", Vector:new(90, 70), D.simple_staffSC, D.simple_staffHF)

        -- local cool_staff = Weapon:new()
        -- cool_staff:init(2, "The cooler staff", Vector:new(200, 90), D.cool_staffSC, D.cool_staffHF)

        local power_staff = Weapon:new()
        power_staff:init(5, "The powerful staff", Vector:new(150, 40), D.power_staffSC, D.power_staffHF)

        -- local gold_staff = Weapon:new()
        -- gold_staff:init(10, "You achieved capitalism", Vector:new(250, 40), D.gold_staffSC, D.gold_staffHF)

        local troll = Monster:new()
        troll:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {0.5, "simple_staff", D.simple_staffSC, D.simple_staffHF},
        {0.8, "coin", D.coinSC}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(150, 50), D.trollSC, D.trollHF)

        local rhino = Monster:new()
        rhino:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {1, "healthPotion", D.redPotionSC}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(150, 150), D.rhinoSC, D.rhinoHF)

    --- Room 2 ---
    elseif roomNbr == 2 then
        --addind everything we want on map (monsters and items)

        --INITIALISATION OF MONSTERS AND ITEMS
        -- local rhino = Monster:new()
        -- rhino:init("rhino", 50, "simple", 0.5, 0.5, "epee", Vector:new(88, 40), D.rhinoSC, D.rhinoHF)

        local troll = Monster:new()
        troll:init({{1, "coin", D.coinSC}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(170, 90), D.trollSC, D.trollHF)

        local troll = Monster:new()
        troll:init({{1, "coin", D.coinSC}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(185, 90), D.trollSC, D.trollHF)

        local rhino = Monster:new()
        rhino:init({{0.33, "damagePotion", D.yellowPotionSC}, {0.33, "speedPotion", D.bluePotionSC}, {1, "coin", D.coinSC}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(88, 40), D.rhinoSC, D.rhinoHF)

        local rhino = Monster:new()
        rhino:init({{0.33, "damagePotion", D.yellowPotionSC}, {0.33, "speedPotion", D.bluePotionSC}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(188, 40), D.rhinoSC, D.rhinoHF)

        local rhino = Monster:new()
        rhino:init({{0.33, "damagePotion", D.yellowPotionSC}, {0.33, "speedPotion", D.bluePotionSC}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(288, 40), D.rhinoSC, D.rhinoHF)

        local offset = 30

        local goldCoin2 = Coin:new()
        goldCoin2:init(3, "coin of gold", Vector:new(160+offset, 70), D.coinSC)
        local goldCoin3 = Coin:new()
        goldCoin3:init(3, "coin of gold", Vector:new(170+offset, 70), D.coinSC)
        local goldCoin4 = Coin:new()
        goldCoin4:init(3, "coin of gold", Vector:new(140+offset, 70), D.coinSC)
        local goldCoin5 = Coin:new()
        goldCoin5:init(3, "coin of gold", Vector:new(130+offset, 70), D.coinSC)

        local goldCoin1 = Coin:new()
        goldCoin1:init(3, "coin of gold", Vector:new(150+offset,80), D.coinSC)
        local goldCoin6 = Coin:new()
        goldCoin6:init(3, "coin of gold", Vector:new(180+offset, 80), D.coinSC)
        local goldCoin7 = Coin:new()
        goldCoin7:init(3, "coin of gold", Vector:new(120+offset, 80), D.coinSC)

        local goldCoin8 = Coin:new()
        goldCoin8:init(3, "coin of gold", Vector:new(190+offset, 90), D.coinSC)
        local goldCoin9 = Coin:new()
        goldCoin9:init(3, "coin of gold", Vector:new(110+offset, 90), D.coinSC)

        local goldCoin10 = Coin:new()
        goldCoin10:init(3, "coin of gold", Vector:new(190+offset, 100), D.coinSC)
        local goldCoin11 = Coin:new()
        goldCoin11:init(3, "coin of gold", Vector:new(110+offset, 100), D.coinSC)

        local goldCoin12 = Coin:new()
        goldCoin12:init(3, "coin of gold", Vector:new(180+offset, 110), D.coinSC)
        local goldCoin13 = Coin:new()
        goldCoin13:init(3, "coin of gold", Vector:new(120+offset, 110), D.coinSC)

        local goldCoin14 = Coin:new()
        goldCoin14:init(3, "coin of gold", Vector:new(170+offset, 120), D.coinSC)
        local goldCoin15 = Coin:new()
        goldCoin15:init(3, "coin of gold", Vector:new(130+offset, 120), D.coinSC)

        local goldCoin16 = Coin:new()
        goldCoin16:init(3, "coin of gold", Vector:new(140+offset, 130), D.coinSC)
        local goldCoin17 = Coin:new()
        goldCoin17:init(3, "coin of gold", Vector:new(160+offset, 130), D.coinSC)

        local goldCoin18 = Coin:new()
        goldCoin18:init(3, "coin of gold", Vector:new(150+offset, 140), D.coinSC)



    --- Room 3 ---
    elseif roomNbr == 3 then
        local damagePotion = Consumable:new()
        damagePotion:init("damage", 1, "potion of damage", Vector:new(48, 24), D.yellowPotionSC)

        local goldCoin = Coin:new()
        goldCoin:init(3, "coin of gold", Vector:new(32, 134), D.coinSC)

        local goldCoin2 = Coin:new()
        goldCoin2:init(3, "coin of gold", Vector:new(260, 140), D.coinSC)

        local goldCoin3 = Coin:new()
        goldCoin3:init(3, "coin of gold", Vector:new(280, 140), D.coinSC)

        local simple_staff = Weapon:new()
        simple_staff:init(1, "The simple staff", Vector:new(190, 120), D.simple_staffSC, D.simple_staffHF)

        local troll = Monster:new()
        troll:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {0.5, "simple_staff", D.simple_staffSC, D.simple_staffHF},
        {0.8, "coin", D.coinSC}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(120, 24), D.trollSC, D.trollHF)

        local troll2 = Monster:new()
        troll2:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {0.5, "simple_staff", D.simple_staffSC, D.simple_staffHF},
        {0.8, "coin", D.coinSC}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(120, 145), D.trollSC, D.trollHF)

        local troll3 = Monster:new()
        troll3:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {0.5, "simple_staff", D.simple_staffSC, D.simple_staffHF},
        {0.8, "coin", D.coinSC}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(184, 145), D.trollSC, D.trollHF)

        local troll4 = Monster:new()
        troll4:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {0.5, "simple_staff", D.simple_staffSC, D.simple_staffHF},
        {0.8, "coin", D.coinSC}},
        "troll", 80, "advanced", 0.3, "epee", Vector:new(184, 24), D.trollSC, D.trollHF)

        local rhino = Monster:new()
        rhino:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {1, "healthPotion", D.redPotionSC}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(56, 34), D.rhinoSC, D.rhinoHF)

        local rhino3 = Monster:new()
        rhino3:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {1, "healthPotion", D.redPotionSC}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(40, 34), D.rhinoSC, D.rhinoHF)

        local rhino2 = Monster:new()
        rhino2:init({{0.1, "gold_staff", D.gold_staffSC, D.gold_staffHF}, {1, "healthPotion", D.redPotionSC}},
        "rhino", 50, "simple", 0.5, "epee", Vector:new(264, 80), D.rhinoSC, D.rhinoHF)
    end
end


return RoomObjects