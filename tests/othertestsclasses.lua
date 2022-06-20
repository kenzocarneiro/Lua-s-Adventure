Dog = {a = 5}                                   -- 1.

function Dog:new()                         -- 2.
  local newObj = {sound = 'woof'}                -- 3.
  self.__index = self                      -- 4.
  print("new :"..tostring(self))
  return setmetatable(newObj, self)        -- 5.
end

function Dog:makeSound()                   -- 6.
  print('I say ' .. self.sound)
  print("makesound :"..tostring(self))
end

local mrDog = Dog:new()                          -- 7.
mrDog:makeSound()

print("Dog :"..tostring(Dog))
print("mrDog :"..tostring(mrDog))


local function test()
  print("test!!!!")
end

test()
