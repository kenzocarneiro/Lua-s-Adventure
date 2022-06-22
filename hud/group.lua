local Group = {}


-- Classe mère Groupe
function Group:new()
    self.__index = self
    local myGroup = {}
    setmetatable(myGroup, self)
    
    -- initialisation
    myGroup.elements = {}

    return myGroup
end

function Group:addElement(pElement, key)
    if key == nil then
        table.insert(self.elements, pElement)
    else
        self.elements[key] = pElement
    end
end

function Group:setVisible(pVisible)
    for n,v in pairs(self.elements) do
        v:setVisible(pVisible)
    end
end

function Group:draw()
    love.graphics.push()
    for n,v in pairs(self.elements) do
        v:draw()
    end
    love.graphics.pop()
end

function Group:update(dt)
    for n,v in pairs(self.elements) do
        v:update(dt)
    end
end

function Group:__tostring()
    local str = "Group :\n"
    for k, v in pairs(self.elements) do
        str = str .. k .. " : " .. tostring(v) .. "\n"
    end
    return str
end

return Group