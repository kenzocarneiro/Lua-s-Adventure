if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

--bof
local classWithInheritance = require("classWithInheritance")
--mieux
local Element = require("hudelement")
local Panel = require("panel")

local element = classWithInheritance.newElement(100, 200)
local panel = classWithInheritance.newPanel(200, 300, 300, 400)

element:draw()
panel:draw()
print("\n")

local element2 = Element:new(100, 200)
local panel2 = Panel:new(200, 300, 300, 400)

element2:draw()
panel2:draw()
print("\n")

panel2:add(10)
panel2:draw()
