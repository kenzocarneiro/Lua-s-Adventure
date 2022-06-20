Room = {defaultLength = 40, defaultHeight = 30}

function Room:new(length, height)
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



end


function Room:draw()
    
end

return Room