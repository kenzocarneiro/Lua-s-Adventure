local GUI = {}

function GUI.newElement(pX, pY)
    local myElement = {}
    myElement.X = pX
    myElement.Y = pY
    myElement.Visible = true
    function myElement:draw()
        print("Element draw at " .. self.X .. "," .. self.Y)
    end
    function myElement:update(dt)
        --print("newElement / update / Not implemented")
    end
    function myElement:setVisible(pVisible)
        self.Visible = pVisible
    end
    return myElement
end

function GUI.newPanel(pX, pY, pW, pH)
    local myPanel = GUI.newElement(pX, pY)
    myPanel.W = pW
    myPanel.H = pH
    function myPanel:draw()
        print("Panel draw at " .. self.X .. "," .. self.Y)
    end
    return myPanel

end

return GUI