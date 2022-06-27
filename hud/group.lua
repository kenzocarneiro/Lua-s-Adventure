local Group = {}


-- Classe mère Groupe
function Group:new()
    self.__index = self
    local myGroup = {}
    setmetatable(myGroup, self)

    -- initialisation
    myGroup.elements = {}
    myGroup.visible = true

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
    self.visible = pVisible
    for n,v in pairs(self.elements) do
        v:setVisible(pVisible)
    end
end

function Group:draw()
    love.graphics.push()
    for n,v in self.pairsByKeys(self.elements) do
        if n ~= "bossText" or G_room.number == 4 then -- BOSS
            v:draw()
        end
    end
    love.graphics.pop()
end

function Group:update(dt)
    for n,v in self.pairsByKeys(self.elements) do
        v:update(dt)
    end
end

function Group.pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then return nil
      else return a[i], t[a[i]]
      end
    end
    return iter
  end

function Group:__tostring()
    local str = "Group :\n"
    for k, v in pairs(self.elements) do
        str = str .. k .. " : " .. tostring(v) .. "\n"
    end
    return str
end

return Group