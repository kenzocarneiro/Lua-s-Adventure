local Sprite = require("sprite/sprite")
local RoomObjects = require("maps/roomObjects")

--- Class representing the Room.
--- @class Room
--- @field number number
--- @field music love.audio
--- @field exit table
--- @field entrance table
--- @field defaultLength number
--- @field defaultHeight number
--- @field isFinished boolean
--- @field tileSize number
--- @field tileRealSize number
--- @field tiles table<string, any>
--- @field walls table<string, any>
--- @field objectsGrid table<string, any>
--- @field spawnCharacters boolean
--- @field createObjects fun(roomNbr:Room)
Room = {defaultLength = 40, defaultHeight = 30, createObjects = RoomObjects.createObjects}

local dungeon_tileset = Sprite:new("img/dungeon_topdown.png", true, "idle", 8, 8, Vector:new(0, 0), false)

local collision_tiles_list = {[1]="full", [2]="full", [3]="right", [4]="left", [5]="full", [6]="full", [7]="obj",
    [9]="right", [10]="left", [11]="right", [12]="left", [13]="full", [14]="full",
    [17]="right", [18]="left", [19]="right", [20]="left", [21]="full", [22]="full"}

--- Constructor of Room
--- @param roomNbr number
--- @return Room r
function Room:new(roomNbr, noEntrance, entrance, exit)
    local r = {}
    setmetatable(r, self)
    self.__index = self
    r.number = roomNbr

    local tiled_rooms = {require("maps/room"..r.number)}

    r.isFinished = false
    r.tileRealSize = 32
    r.tileSize = 8

    if G_soundOn then
        r.music = love.audio.newSource("sound/bgmusic/room"..roomNbr..".mp3", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
        r.music:setVolume(0.5)
        r.music:setLooping(true)
        r.music:play()
    end

    local tiled_room = tiled_rooms[1]
    local tile_layer = tiled_room.layers[1]
    local map_width = tile_layer.width
    local map_height = tile_layer.height

    if not noEntrance then r.entrance = {row = map_height/2, col=2} end
    r.exit = {row=map_height/2, col=map_width-1}

    if G_player and not noEntrance then
        G_player.pos.x = (r.entrance["col"]+0.5)*r.tileSize
        G_player.pos.y = (r.entrance["row"]-0.5)*r.tileSize
    end

    if G_soundOn and roomNbr ~= 0 then
        local won = love.audio.newSource("sound/soundeffects/change_room.wav", "static") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
        won:setVolume(0.5)
        won:play()
    end

    -- Initialisation de la carte :
    local t = {}
    for l = 1,map_height do
        local line = {}
        for c = 1, map_width do
            -- print(tile_layer.data[(l-1)*map_width + c])
            local tile = {data=tile_layer.data[(l-1)*map_width + c]}
            line[c]=tile
        end
        t[l]=line
    end

    r.tiles = t

    -- Initialisation des murs :
    local wall_layer = tiled_room.layers[2]

    local w = {}
    for l = 1,map_height do
        local line = {}
        for c = 1, map_width do
            -- print(tile_layer.data[(l-1)*map_width + c])
            local tile = {data=wall_layer.data[(l-1)*map_width + c]}
            if collision_tiles_list[tile.data] then
                local wall_type = collision_tiles_list[tile.data]

                if wall_type == "full" then
                    tile.hitbox=Hitbox:new(Vector:new((c-1)*8 + r.tileSize, (l-1)*8 + r.tileSize), "hitbox", {tile=true}, 8, 8, Vector:new(0, 0), -1)
                elseif wall_type == "right" then
                    tile.hitbox=Hitbox:new(Vector:new((c-1)*8 + r.tileSize + 4, (l-1)*8 + r.tileSize), "hitbox", {tile=true}, 4, 8, Vector:new(0, 0), -1)
                elseif wall_type == "left" then
                    tile.hitbox=Hitbox:new(Vector:new((c-1)*8 + r.tileSize, (l-1)*8 + r.tileSize), "hitbox", {tile=true}, 4, 8, Vector:new(0, 0), -1)
                else
                    error("Unknown wall type : " .. wall_type)
                end
                G_hitboxes[#G_hitboxes+1]=tile.hitbox
            end
            line[c]=tile
        end
        w[l]=line
    end

    r.walls = w

    -- Initialisation de la grille pour placer les objets :
    local obj = {}
    for l = 1,map_height do
        local line = {}
        for c = 1, map_width do
            -- Pas le bon type pour le moment mais pg
            local object = {data=0}
            line[c]=object
        end
        obj[l]=line
    end

    if not noEntrance then obj[r.entrance["row"]][r.entrance["col"]].data = 7 end

    r.objectsGrid = obj
    r.spawnCharacter = Vector:new(0, 0) -- syntaxe à mettre

    r.createObjects(roomNbr)

    -- r.objectsGrid[entrance[1]][entrance[2]] = "entrance" -- à ajuster en fonction de la forme de spawn (ici je considère que c'est juste un tableau avec les indices d'une tile dedans)
    -- r.objectsGrid[exit[1]][exit[2]] = "exit" -- meme chose

    -- -- Ici instancier le character

    -- local chara = "."

    -- -- Puis :
    -- r.entities[1] = chara

    -- -- Faire de même avec les ennemis

    -- for nbEnmy = 1,#enemies do
    --     -- Ici instancier l'ennemi
    --     r.entities[nbEnmy + 1] = chara
    -- end
    return r
end

function Room:draw()
    -- Draw the tiles
    for i = 1, #self.tiles do
        for j = 1, #self.tiles[i] do
            local tile = self.tiles[i][j]
            if tile.data ~= 0 then
                local x = (j - 1) * self.tileSize
                local y = (i - 1) * self.tileSize
                love.graphics.draw(dungeon_tileset.loveImg, dungeon_tileset.frames[tile.data], x+self.tileSize, y+self.tileSize)
            end
        end
    end

    -- Draw the walls
    for i = 1, #self.walls do
        for j = 1, #self.walls[i] do
            local tile = self.walls[i][j]
            if tile.data ~= 0 then
                local x = (j - 1) * self.tileSize
                local y = (i - 1) * self.tileSize
                love.graphics.draw(dungeon_tileset.loveImg, dungeon_tileset.frames[tile.data], x+self.tileSize, y+self.tileSize)
            end
        end
    end

    -- Draw the objects
    for i = 1, #self.objectsGrid do
        for j = 1, #self.objectsGrid[i] do
            local tile = self.objectsGrid[i][j]
            if tile.data ~= 0 then
                local x = (j - 1) * self.tileSize
                local y = (i - 1) * self.tileSize
                love.graphics.draw(dungeon_tileset.loveImg, dungeon_tileset.frames[tile.data], x+self.tileSize, y+self.tileSize)
            end
        end
    end
end

-- ----- Ci-gît un début d'algorithme de pathfinding... -----
-- - RIP in peace (= RIP in peace in peace (= RIP in peace in peace in peace (= ...)))

-- -- Returns the tile where the indicated position is
-- --- @param pos Vector The position to use
-- function Room:findTileWithPos(pos)
--     local index = {row=0,col=0}
--     -- i doit être le x du coin supérieur gauche de la carte
--     local i = 0
--     repeat
--         if i*self.tileRealSize <= pos.x <= (i+1)*self.tileRealSize then
--             index.row = i + 1
--         end
--         i = i + 1
--     until (index.row ~= 0) or (i == self.length)

--     -- j doit être le y du coin inférieur gauche de la carte
--     local j = 0
--     repeat
--         if j*self.tileRealSize <= pos.x <= (j+1)*self.tileRealSize then
--             index.col = j + 1
--         end
--         j = j + 1
--     until (index.col ~= 0) or (i == self.height)

--     return index
-- end

-- function Room:getIndexes(tile)
--     return self.findTileWithPos(tile.pixelPos)
-- end

-- -- Returns the tile where the indicated position is
-- --- @param pos Vector The position with which we want to know if it's in the same tile as tile
-- --- @param tile table A tile
-- function Room:isOnTheSameTile(pos,tile)
--     local posTileIndexes = self.findTileWithPos(pos)
--     return self.tiles[posTileIndexes[1]][posTileIndexes[2]] == tile
-- end
-- ------------------------------------------------------

return Room