Room = {defaultLength = 40, defaultHeight = 30}

function Room:new(length, height, entrance, exit, enemies)
    local r = {}
    setmetatable(r, self)
    self.__index = self

    local isFinished = false
    local layer = nil
    local mask = nil

    -- Initialisation de la carte : 
    local t = {}
    for l = 1,height do
        local line = {}
        for c = 1, length do
            -- C'est du full bullshit, c'est juste pour remplir la carte pour l'instant
            local tile = {id=true}
            line[c]=tile
        end
        t[l]=line
    end

    r.tiles = t

    -- Initialisation de la grille pour placer les objets : 
    local obj = {}
    for l = 1,height do
        local line = {}
        for c = 1, length do
            -- Pas le bon type pour le moment mais pg
            local object = {id=true}
            line[c]=object
        end
        obj[l]=line
    end

    r.objectsGrid = obj
    r.spawnCharacter = Vector() -- syntaxe à mettre

    r.objectsGrid[entrance[1]][entrance[2]] = "entrance" -- à ajuster en fonction de la forme de spawn (ici je considère que c'est juste un tableau avec les indices d'une tile dedans)
    r.objectsGrid[exit[1]][exit[2]] = "exit" -- meme chose

    -- Ici instancier le character

    local chara = "."

    -- Puis :
    r.entities[1] = chara

    -- Faire de même avec les ennemis

    for nbEnmy = 1,enemies.length
    



end


function Room:draw()
    
end

return Room