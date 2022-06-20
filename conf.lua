
--- Configurate the game
--- @param t table
function love.conf(t)
    print("this is executed!")
    t.window.width = 1000
    t.window.height = 800
    t.window.title = "My game!"
end
