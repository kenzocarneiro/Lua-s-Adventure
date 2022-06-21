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

function Group:addElement(pElement)
    table.insert(self.elements, pElement)
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


return Group