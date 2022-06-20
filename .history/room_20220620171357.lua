Room = {defaultLength = 40, defaultHeight = 30}

function Room:new(length, height)
    local r = {}
    setmetatable(r, self)
    self.__index = self

    local isFinished = false
    local layer = nil
    local mask = nil

    -- Initialisation de la carte : 
    local tiles = {}
    for l = 1,height do
        local line = {}
        for c = 1, length do
            -- C'est du full bullshit, c'est juste pour remplir la carte pour l'instant
            local tile = {id=true}
            local tileNum = "tile"..l.."/"..c
            line.insert(tile,"[tileNum]")
        end
        tiles.insert(line)
    end

end


function Room:draw()
    
end

return Room