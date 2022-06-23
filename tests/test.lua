

local function f(...)
    -- iterate over all the arguments
    for i, v in pairs({...}) do
        print(i, v)
    end
end

f({1, 2, 3})