function love.load()
    image = love.graphics.newImage("cake.png")
    love.graphics.setNewFont(12)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setBackgroundColor(255, 255, 255)
    numx = 10
    numy = 10
    dt = 1
    imgx = 0
    imgy = 0
end

function love.update()
    keyboardControl()
    mouseControl()
end

function love.draw()
    love.graphics.draw(image, imgx, imgy)
    love.graphics.print("Click and drag the cake around or use the arrow keys", 10, 10)
end

--[[function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        imgx = x - 128
        imgy = y - 128
    end    
end--]]

function love.focus(f)
    if not f then 
        print("LOST FOCUS")
    elseif f then
        print("GAINED FOCUS")
    end
end

function love.quit()
    print("Thanks for playing! Come back soon!")
end

-- keyboard control
function keyboardControl()
    if love.keyboard.isDown("up") then
        print("up")
        numy = numy - 10 * dt -- this would increment num by 10 per second
        imgy = numy
    elseif love.keyboard.isDown("down") then 
        print("down")
        numy = numy + 10 * dt
        imgy = numy
    end

    if love.keyboard.isDown("right") then 
        print("right")
        numx = numx + 10 * dt
        imgx = numx
    elseif love.keyboard.isDown("left") then
        print("left")
        numx = numx - 10 * dt
        imgx = numx
    end
end

-- mouse control
function mouseControl()
    if love.mouse.isDown(1) then
        numx = love.mouse.getX() - 128
        numy = love.mouse.getY() - 128
        imgx = numx
        imgy = numy
        print("x", numx)
        print("y", numy)
    end
end