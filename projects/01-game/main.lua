require("libs.tile-map")

function love.load()
    love.window.setMode(600, 600, nil)

    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getWidth()
    tileWidth = windowWidth / 5
    tileHeight = windowHeight / 5
    newFood = true

    -- Map
    mapOfTiles = createMap(tileWidth, tileHeight)

    -- Actor
    actor = createTileMap("fill", 0, 0, tileWidth, tileHeight, "actor")
    actor.direction = "right"

    -- Food
    food = createTileMap("fill", 0, 0, tileWidth, tileHeight, "food")
    foodNewPosition()

    -- Actor Food positon
    mapOfTiles[1][1] = actor

    time = 0
end

function love.update(dt)

    time = time + dt
    print("time\t", time)
    if time >= 1 then
        moveActor(actor.direction)
        if newFood then
            foodNewPosition()
        end
    end
    
    print("actor x:\t",actor.x)
    print("actor y:\t",actor.y)
    print("actor direction:",actor.direction)
    print("food x:\t", food.x)
    print("food y:\t", food.y)
    print("random", math.random(0, 5))
    print("tileWidth", tileWidth)
    print("/-------------------------/")
   
end

function love.draw()

    -- print mapOfTiles
    for i, line in ipairs(mapOfTiles) do
        for j, tile in ipairs(line) do
            if tile.type == "tile" then
                print("tile", i, j)
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle(tile.mode, tile.x, tile.y, tile.width, tile.height) 
            elseif tile.type == "actor" then
                -- draw actor
                print("actor", i, j)
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle(tile.mode, tile.x, tile.y, tile.width, tile.height) 
            else
                 -- draw food
                print("food", i, j)
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle(tile.mode, tile.x, tile.y, tile.width, tile.height) 
            end   
            
        end
    end

end

-- Functions    ----------------------------------------------------------------------

function love.keypressed(key)
    actor.direction = key
end

function moveActor(direction)
    
    if direction == "right" then
        newActorPosition("x", 1)
    elseif direction == "left" then
        newActorPosition("x", -1)
    elseif direction == "up" then
        newActorPosition("y", -1)
    elseif direction == "down" then
        newActorPosition("y", 1)
    end

end

function newActorPosition(axis, direction)
    local actor_x_position = (actor.x / tileWidth) + 1
    local actor_y_position = (actor.y / tileHeight) + 1
    local new_tile = createTileMap("line", actor.x, actor.y, tileWidth, tileHeight, "tile")
    time = 0

    if axis == "x" then
        local actor_map_new_position = actor_x_position + 1 * direction
        local actor_new_position = actor.x + tileWidth * direction
        if actor_new_position < windowWidth and actor_new_position >= 0 then
            actor.x = actor_new_position
            if mapOfTiles[actor_map_new_position][actor_y_position] == food then
                print("come x")
                newFood = true
            end
            mapOfTiles[actor_map_new_position][actor_y_position] = actor
            mapOfTiles[actor_x_position][actor_y_position] = new_tile
        end
        return
    elseif axis == "y" then
        local actor_map_new_position = actor_y_position + 1 * direction
        local actor_new_position = actor.y + tileHeight * direction
        if actor_new_position < windowWidth and actor_new_position >= 0  then
            actor.y = actor_new_position
            if mapOfTiles[actor_x_position][actor_map_new_position] == food then
                print("come y")
                newFood = true
            end
            mapOfTiles[actor_x_position][actor_map_new_position] = actor
            mapOfTiles[actor_x_position][actor_y_position] = new_tile
        end
        return
    end
end

function foodNewPosition()
    print("fui chamado", newFood)
    
    while newFood do
        print("estou no loop")
        local food_x_map = math.random(1, 5)
        local food_y_map = math.random(1, 5)
        local food_x = (food_x_map - 1) * tileWidth
        local food_y = (food_y_map - 1) * tileHeight

        print("novo x", food_x)
        print("novo y", food_y)
        print("food_x_map ", food_x_map)
        print("food_y_map ", food_y_map)

        if food_x ~= actor.x or food_y ~= actor.y then
            food.x = food_x
            food.y = food_y
            mapOfTiles[food_x_map][food_y_map] = food
            newFood = false
        end

    end
end