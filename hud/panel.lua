local Element = require("hud/element")

local Panel = {}


-- Classe fille Panel qui hérite d'Element
function Panel:new(pX, pY, pW, pH, pColorOut)
    self.__index = self
    setmetatable(self, {__index = Element}) --heritage

    local myPanel = Element.new(self, pX, pY) --appel constructeur de la classe mère
    setmetatable(myPanel, self)
    
    -- initialisation
    myPanel.w = pW or 10
    myPanel.h = pH or 10
    myPanel.colorOut = pColorOut or {255, 255, 255}
    myPanel.image = nil
    myPanel.isHover = false
    myPanel.lstEvents = {}

    return myPanel
end

function Panel:setImage(pImage, pScale)
    self.image = pImage
    self.scale = pScale or 1
    self.w = pImage:getWidth()
    self.h = pImage:getHeight()
end


function Panel:setEvent(pEventType, pFunction)
    print("setEvent : " .. pEventType)
    self.lstEvents[pEventType] = pFunction
end
  
function Panel:update(dt)
    local mx,my = love.mouse.getPosition()
    if self.x < mx and mx < self.x + self.w and self.y < my and my < self.y + self.h then
        if not self.isHover then
            self.isHover = true
            if self.lstEvents["hover"] ~= nil then
                self.lstEvents["hover"]("begin")
            end
        end
    else 
        if self.isHover then
            self.isHover = false
            if self.lstEvents["hover"] ~= nil then
                self.lstEvents["hover"]("end")
            end
        end
    end
end

function Panel:draw()
    if not self.visible then return end
    if self.colorOut ~= nil then
        love.graphics.setColor(self.colorOut[1]/255, self.colorOut[2]/255, self.colorOut[3]/255)
    else
        love.graphics.setColor(255/255,255/255,255/255)
    end
    if self.image == nil then
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    else

        love.graphics.setColor(255/255,255/255,255/255)
        love.graphics.draw(self.image, self.x, self.y, 0, self.scale)
    end
end

function Panel:add(x)
    self.x = self.x + x
end

return Panel
