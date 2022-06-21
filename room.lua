--- Class representing the Room.
--- @class Room
--- @field defaultLength number
--- @field defaultHeight number
--- @field isFinished boolean
--- @field tileSize number
--- @field tileRealSize number
--- @field tiles any
--- @field walls any
--- @field objectsGrid string[][]
--- @field spawnCharacters boolean
Room = {defaultLength = 40, defaultHeight = 30}

local dungeon_tileset = Sprite:new("img/dungeon_topdown.png", true, "idle", 8, 8, Vector:new(0, 0), false)

local detection_tiles_list = {[1]="full", [2]="full", [3]="right", [4]="left", [5]="full", [6]="full", [7]="obj",
    [9]="right", [10]="left", [11]="right", [12]="left", [13]="full", [14]="full",
    [17]="right", [18]="left", [19]="right", [20]="left", [21]="full", [22]="full"}

local tiled_rooms = {require("maps/room1")}

--- Constructor of Room
--- @param roomNbr number
--- @return Room r
function Room:new(roomNbr)
    local r = {}
    setmetatable(r, self)
    self.__index = self

    r.isFinished = false
    r.tileRealSize = 32
    r.tileSize = 8

    local tiled_room = tiled_rooms[roomNbr]
    local tile_layer = tiled_room.layers[1]
    local map_width = tile_layer.width
    local map_height = tile_layer.height
    local entrance = {}
    local exit = {}

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
            if detection_tiles_list[tile.data] then
                local detection_type = detection_tiles_list[tile.data]
                print((l-1)*map_width)
                tile.hitbox=Hitbox:new(Vector:new((c-1)*8 + r.tileSize, (l-1)*8 + r.tileSize), 8, 8, Vector:new(0, 0))
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
            local object = {id=true}
            line[c]=object
        end
        obj[l]=line
    end

    r.objectsGrid = obj
    r.spawnCharacter = Vector:new(0, 0) -- syntaxe à mettre

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

function Room:draw(draw_hitbox)
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

                if draw_hitbox then
                    tile.hitbox:draw()
                end
            end
        end
    end
end

-- Returns the tile where the indicated position is
--- @param pos Vector The position to use
function Room:findTileWithPos(pos)
    local index = {row=0,col=0}
    -- i doit être le x du coin supérieur gauche de la carte
    local i = 0
    repeat
        if i*self.tileRealSize <= pos.x <= (i+1)*self.tileRealSize then
            index.row = i + 1
        end
        i = i + 1
    until (index.row ~= 0) or (i == self.length)

    -- j doit être le y du coin inférieur gauche de la carte
    local j = 0
    repeat
        if j*self.tileRealSize <= pos.x <= (j+1)*self.tileRealSize then
            index.col = j + 1
        end
        j = j + 1
    until (index.col ~= 0) or (i == self.height)

    return index
end

function Room:getIndexes(tile)
    return self.findTileWithPos(tile.pixelPos)
end

-- Returns the tile where the indicated position is
--- @param pos Vector The position with which we want to know if it's in the same tile as tile
--- @param tile table A tile
function Room:isOnTheSameTile(pos,tile)
    local posTileIndexes = self.findTileWithPos(pos)
    return self.tiles[posTileIndexes[1]][posTileIndexes[2]] == tile
end

return Room