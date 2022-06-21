
-- I) General Information regarding documentation

-- This is a comment
--- This is documentation
-- Documentation always start with "---" while simple comments start with "--"

-- Try to always end your documentation with a period : ".", because this is better displayed in VS Code.



-- II) Functions

-- Simple documentation:

--- Compute the square root of the sum of two numbers.
--- @param x number
--- @param y number
--- @return number
function SqAdd(x, y)
    return math.sqrt(x+y)
end

-- For all types of documents, you can go into more details:
--- Compute the square root of the sum of two numbers.
--- @param x number The first number.
--- @param y number The second number
--- @return number result
function SqAdd(x, y)
    return math.sqrt(x+y)
end



-- III) OOP

-- III.1) Classes

--- Class representing clients' accounts.
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


-- III.2) Inheritance

--- Class representing VIP accounts.
--- @class VIPAccount:Account VIPAccount is a subclass of Account.
VIPAccount = Account:new()

--- Constructor of VIPAccount.
--- @return VIPAccount
function VIPAccount:new() return Account:new() end
-- The line above is necessary in order to have instanced variables documented with the right type: VIPAccount.

local s = VIPAccount:new()
-- s is automatically VIPAccount, as you can see here.
