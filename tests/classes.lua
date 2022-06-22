-- local array = {3, 0.43, 9, 4}

-- I) Truc étragne sur les dictionnaires - Syntactic Sugar
-- a = "salut"
-- local dict = {a=3, [a] = 4} -- dict = {["a"] = 3}
-- local dict2 = {543=2}
-- print(dict2[543])
-- print(dict2["543"])


-- local a = "salut"
-- local b = nil
-- local dict = {a=3, b=4} -- -> dict["a"] = 3 and dict["b"] = 4
-- local dict = {["a"]=3, ["b"]=4}
-- print(dict.a) -- -> dict["a"] = 3
-- print(dict[a]) -- -> dict["salut"] = 3
-- print(dict2[a])
-- local dict2 = {[a]=1, [6]=9} -- -> dict2["salut"] = 1 and dict2[6] = 9



-- II) Orienté objet en Lua
-- local Account = {amount=10}

-- function Account:new()
--     local o = {}   -- create object if user does not provide one
--     setmetatable(o, self)
--     self.__index = self
--     return o
-- end



-- function Account:add(amount)
--     self.amount = self.amount + amount
-- end

-- function Account:delete()
--     self.amount = nil
-- end

-- function Account:show_amount()
--     print(self.amount)
-- end

-- local t = Account:new()
-- local t2 = Account:new()   -- Account.new(Account)

-- t2:add(3)
-- t2:show_amount()
-- t2:delete()
-- t2:show_amount() -- t2.show_amount(t2)
-- Account:show_amount()



--- III) Héritage
Account = {balance = 0, val=3}

function Account:new()
    print("[init]", self)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end


function Account:deposit(v)
    print("I'm an Account")
    self.balance = self.balance + v
end

function Account:withdraw(v)
    if v > self.balance then error("insufficient funds") end
    self.balance = self.balance - v
end


VIPAccount = Account:new()

function VIPAccount:new() return Account.new(self) end

local s = VIPAccount:new()

VIPAccount.type = "VIP"

function VIPAccount:deposit(v)
    print("I'm a VIP account")
    Account.deposit(self, v)
end
local s2 = VIPAccount:new()
s:deposit(100)
s2:deposit(50)
print(s.balance)
print(s2.balance)
print(s.type)
print(s2.type)
print(getmetatable(s) == getmetatable(s2))