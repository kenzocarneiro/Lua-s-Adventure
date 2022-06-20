Room = {}

function Room:new()
    local r = {}
    setmetatable(r, self)
    self.__index = self

    local isFinished = false
    local layer = nil
    local mask = nil

end


function Room:draw()
    
end

return Room