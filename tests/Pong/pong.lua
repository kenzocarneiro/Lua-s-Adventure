Pong = {}

local Racket = require("tests/Pong/racket")
local Ball = require("tests/Pong/ball")
local Field = require("tests/Pong/field")

-- Load function (call one time)
function Pong.load()
    racketLeft = Racket:new(90, 250)
    racketRight = Racket:new(710, 250)
    ball = Ball:new(400, 300)
    field = Field:new(50, 50)
end

-- Main loop for calcul
function Pong.update(dt)
    -- keypress
    --racketLeft
    if love.keyboard.isDown("z") then
        racketLeft:moveY(-5)
    end
    if love.keyboard.isDown("s") then
        racketLeft:moveY(5)
    end
    --racketRight
    if love.keyboard.isDown("up") then
        racketRight:moveY(-5)
    end
    if love.keyboard.isDown("down") then
        racketRight:moveY(5)
    end
    --print(racketLeft:top(), racketLeft:bottom())
    -- ball
    ball:move()

    --bounce at the top or at the bottom
    if ball:top() == field:top() or ball:bottom() == field:bottom() then
        ball:mulDY(-1)
    end

    if (ball:left() == racketLeft:right() and racketLeft:top() <= ball:top() and ball:bottom() <= racketLeft:bottom()) or (ball:right() == racketRight:left() and racketRight:top() <= ball:top() and ball:bottom() <= racketRight:bottom()) then
        ball:mulDX(-1)
    end

    if ball:left() <= field:left() or ball:right() >= field:right() then
        ball:place(400, 300)
    end

end

-- Main loop for drawing
-- function love.draw()
--     love.graphics.print("Hello World", 400, 300)
-- end
function Pong.draw()
    racketLeft:draw()
    racketRight:draw()
    ball:draw()
    field:draw()
end

-- functions
function Pong.keypressed(k)
    -- print(k)
	if k == 'escape' then
		love.event.push('quit') -- Quit the game.
	end
end

return Pong
