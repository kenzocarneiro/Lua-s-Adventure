Room = {defaultLength = 40, defaultWidth = 30}

function Room:new(length, width)
    local r = {}
    setmetatable(r, self)
    self.__index = self

    local isFinished = false
    local layer = nil
    local mask = nil

    local tiles = {}

end


function Room:draw()
    
end

return Room