function love.load()
    tick = require "tick"

    -- Create a boolean
    drawRectangle = false

    -- The first argument is a function
    -- The second argument is the time it takes to call the function
    tick.delay(function () drawRectangle = true end, 2)

    --
    x = 30
    y = 50
end

function love.update(dt)
    tick.update(dt)
end

function love.draw()
    -- If drawRectangle is true then draw a rectangle
    if drawRectangle then
        love.graphics.rectangle("fill", 100, 100, 100, 100)
    end

    love.graphics.rectangle("line", x, y, 100, 100)
end

function love.keypressed(key)
    if key == "space" then
        x = math.random(100, 500)
        y = math.random(100, 500)
    end    
end