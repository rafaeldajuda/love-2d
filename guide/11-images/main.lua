function love.load()
    myImage = love.graphics.newImage("sheep.png")
    width = myImage:getWidth()
    height = myImage:getHeight()
    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.update()
    
end

function love.draw()
    love.graphics.setColor(255/255, 200/255, 40/255, 127/255)
    -- love.graphics.setColor(1, 0.78, 0.15, 0.5)
    love.graphics.draw(myImage, 100, 100, 0, 1, 1, width/2, height/2)

    -- Not passing an argument for alpha automatically sets it to 1 again.
    love.graphics.setColor(150/255, 75/255, 75/255)
    love.graphics.draw(myImage, 200, 100, 0, 1, 1, width/2, height/2)
end