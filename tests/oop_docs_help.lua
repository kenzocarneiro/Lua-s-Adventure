
-- Classes

--- Class representing clients' accounts
--- @class Account
--- @field balance number
--- @field val number
Account = {balance = 0, val=3}

--- Constructor of Account.
--- @return Account
function Account:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end


-- Inheritance

--- Class representing VIP accounts
--- @class VIPAccount:Account VIPAccount is a subclass of Account
VIPAccount = Account:new()

--- Constructor of VIPAccount.
--- @return VIPAccount
function VIPAccount:new() return Account:new() end
-- The line above is necessary in order to have instanced variables documented with the right type: VIPAccount.

local s = VIPAccount:new()
-- s is automatically VIPAccount, as you can see here.
