Pong = {}

local Racket = require("tests/Pong/racket")
local Ball = require("tests/Pong/ball")
local Field = require("tests/Pong/field")

-- Load function (call one time)
function Pong.load()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    G_racketLeft = Racket:new(90, 250)
    G_racketRight = Racket:new(screenWidth-90, 250)
    G_ball = Ball:new(screenWidth/2, screenHeight/2)
    G_field = Field:new(50, 50)
end

-- Main loop for calcul
function Pong.update(dt)
    -- keypress
    --racketLeft
    if love.keyboard.isDown("z") then
        G_racketLeft:moveY(-5)
    end
    if love.keyboard.isDown("s") then
        G_racketLeft:moveY(5)
    end
    --racketRight
    if love.keyboard.isDown("up") then
        G_racketRight:moveY(-5)
    end
    if love.keyboard.isDown("down") then
        G_racketRight:moveY(5)
    end
    --print(racketLeft:top(), racketLeft:bottom())
    -- ball
    G_ball:move()

    --bounce at the top or at the bottom
    if G_ball:top() == G_field:top() or G_ball:bottom() == G_field:bottom() then
        G_ball:mulDY(-1)
    end

    if (G_ball:left() == G_racketLeft:right() and G_racketLeft:top() <= G_ball:top() and G_ball:bottom() <= G_racketLeft:bottom()) or (G_ball:right() == G_racketRight:left() and G_racketRight:top() <= G_ball:top() and G_ball:bottom() <= G_racketRight:bottom()) then
        G_ball:mulDX(-1)
    end

    if G_ball:left() <= G_field:left() or G_ball:right() >= G_field:right() then
        G_ball:place(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
    end

end

-- Main loop for drawing
-- function love.draw()
--     love.graphics.print("Hello World", 400, 300)
-- end
function Pong.draw()
    G_racketLeft:draw()
    G_racketRight:draw()
    G_ball:draw()
    G_field:draw()
end

-- functions
function Pong.keypressed(k)
    -- print(k)
	if k == 'escape' then
		love.event.push('quit') -- Quit the game.
	end
end

return Pong
