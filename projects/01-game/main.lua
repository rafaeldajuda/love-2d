function love.load()
    require "libs.tile-map"

    love.window.setMode(600, 600, nil)

    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getWidth()
    tileWidth = windowWidth / 5
    tileHeight = windowHeight / 5

    -- Map
    mapOfTiles = createMap(tileWidth, tileHeight)

    actor = createTileMap("fill", 0, 0, tileWidth, tileHeight)
    actor.direction = "right"

    time = 0
end

function love.update(dt)

    time = time + dt
    print("time\t", time)
    if time >= 1 then
        moveActor(actor.direction)
        time = 0
    end
    
    print("actor x:\t",actor.x)
    print("actor y:\t",actor.y)
    print("actor direction:",actor.direction)
    
    
    
end

function love.draw()

    -- print mapOfTiles
    for i, line in ipairs(mapOfTiles) do
        for j, tile in ipairs(line) do
            love.graphics.rectangle(tile.mode, tile.x, tile.y, tile.width, tile.height)
        end
    end

    love.graphics.rectangle(actor.mode, actor.x, actor.y, actor.width, actor.height)
end

function love.keypressed(key)
    actor.direction = key
end

function moveActor(direction)
    print("fui chamando")
    if direction == "right" then
        actor.x = actor.x + tileWidth
    elseif direction == "left" then
        actor.x = actor.x - tileWidth
    elseif direction == "up" then
            actor.y = actor.y - tileHeight
    elseif direction == "down" then
            actor.y = actor.y + tileHeight
    end

    if actor.x < 0 then
        actor.x = 0
    elseif actor.x >= windowWidth then
        actor.x = windowWidth - tileWidth
    elseif actor.y < 0 then
        actor.y = 0
    elseif actor.y >= windowHeight then
        actor.y = windowHeight - tileHeight
    end

end