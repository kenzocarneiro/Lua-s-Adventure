Room = {defaultLength = 40, defaultHeight = 30}

function Room:new(length, height)
    local r = {}
    setmetatable(r, self)
    self.__index = self

    local isFinished = false
    local layer = nil
    local mask = nil

    local tiles = {}
    for l = 1,height do
        
    end

end


function Room:draw()
    
end

return Room