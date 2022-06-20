--******************* UTILISATION             *****************

-- dans le main.lua, en dehors de toute fonction, pour importer:
--local myGUI = require("GCGUI")
-- pour créer un nouveau groupe :
-- myGroup = myGUI.newGroup()

--********************* EXPLICATION **************

-- Pour la partie interface, on va principalement utiliser des groupes et des éléments

-- un élément : classe générique, on va faire des classes dérivées de element qui seront panel, text, bouton, case à cocher, barre de progression, etc.
-- un groupe va contenir un ensemble d’éléments et proposer des fonctions de visibilité, de display, d’ajout d’éléments...

--module GUI
local GUI = {}


-- Classe Element
local function newElement(pX, pY)
    local myElement = {}
    myElement.X = pX
    myElement.Y = pY
    myElement.Visible = true
    function myElement:draw()
      print("newElement / draw / Not implemented")
    end
    function myElement:update(dt)
        --print("newElement / update / Not implemented")
    end
    function myElement:setVisible(pVisible)
        self.Visible = pVisible
    end
    return myElement
  end


-- classe Groupe
-- les variables commençant par p sont des arguments passés à uhe fonction

function GUI.newGroup()
    local myGroup = {}
    myGroup.elements = {}

    function myGroup:addElement(pElement)
        table.insert(self.elements, pElement)
    end

    function myGroup:setVisibility(pVisibility)
        for n,v in pairs(myGroup.elements) do
            v:setVisibility(pVisibility)
        end
    end

    -- l'utilisation de push / pop dans le draw permet de sauvergarder le contexte graphique au début et de le restaurer à la fin
    function myGroup.draw()
        love.graphics.push()
        for n,v in pairs(myGroup.elements) do
            v:draw()
        end
        love.graphics.pop()
    end
      
      function GUI.newPanel(pX, pY, pW, pH)
        local myPanel = newElement(pX, pY)
        myPanel.W = pW
        myPanel.H = pH
        myPanel.Image = nil
      
        function myPanel:setImage(pImage)
          self.Image = pImage
          self.W = pImage:getWidth()
          self.H = pImage:getHeight()
        end
      
        function myPanel:drawPanel()
          love.graphics.setColor(255,255,255)
          if self.Image == nil then
            love.graphics.rectangle("line", self.X, self.Y, self.W, self.H)
          else
            love.graphics.draw(self.Image, self.X, self.Y)
        end
      end
    
      function myPanel:draw()
        if self.Visible == false then return end
        self:drawPanel()
      end
      
      return myPanel
    end
end
      
return GUI

