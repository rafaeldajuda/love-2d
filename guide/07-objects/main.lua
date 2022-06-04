-- By declaring it here we can access it everywhere in this file.
local listOfRectangles = {}

function love.load()
    
end

function love.update(dt)
    for i, v in ipairs(listOfRectangles) do
        v.x = v.x + v.speed * dt    
    end
end

function love.draw()
    for i, v in ipairs(listOfRectangles) do
        love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
    end
end

-- love functions

function love.keypressed(key)
    if key == "space" then
        createRect()
    end
end

-- others functions

function createRect()
    rect = {}
    rect.x = 100
    rect.y = 100
    rect.width = 70
    rect.height = 90
    rect.speed = 100

    table.insert(listOfRectangles, rect)
end