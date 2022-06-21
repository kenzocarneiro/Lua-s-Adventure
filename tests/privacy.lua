
-- IV) Encapsulation
local function new_save(score)
    score = score
    local get_score = function()
        return score
    end
    local function add_score(add) -- Same thing as: local add_score = function () ... end
        score = score + add
    end
    return {get_score=get_score,add_score=add_score}
end


local my_save = new_save(1003)

my_save.score = 3
print(my_save.score)

print(my_save.get_score())
my_save.add_score(7)
print(my_save.score)
print(my_save.get_score())