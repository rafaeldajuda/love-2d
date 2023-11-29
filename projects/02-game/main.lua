function love.load() 
    -- imports
    require "actor"

    -- colors
    green = function () return 0, 255, 0 , 1 end

    love.window.setTitle("meteor shoot")
    love.window.setMode(600, 600, nil)

    mainActor = loadActor("fill", 0, 540, 60, 60, "main")
    actorDirection = "right"
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        moveActor("left", dt)
    elseif love.keyboard.isDown("right") then
        moveActor("right", dt)
    end
end

function love.draw()
    love.graphics.setColor(green())
    love.graphics.rectangle(mainActor.mode, mainActor.x, mainActor.y, mainActor.width, mainActor.height)
end

-- other functions

function moveActor(direction, dt)
    if direction == "left"  then
        mainActor.x = mainActor.x - 240 * dt
    elseif direction == "right" then
        mainActor.x = mainActor.x + 240 * dt
    end 
end