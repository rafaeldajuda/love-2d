require("libs.tile-map")

function love.load()
    love.window.setMode(600, 600, nil)

    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getWidth()
    tileWidth = windowWidth / 5
    tileHeight = windowHeight / 5

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
    mapOfTiles[3][3] = food

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
    print("food x:\t", food.x)
    print("food y:\t", food.y)
    print("/-------------------------/")
   
end

function love.draw()

    -- print mapOfTiles
    love.graphics.setColor(1, 1, 1)
    for i, line in ipairs(mapOfTiles) do
        for j, tile in ipairs(line) do
            love.graphics.rectangle(tile.mode, tile.x, tile.y, tile.width, tile.height)
        end
    end

    -- draw actor
    love.graphics.rectangle(actor.mode, actor.x, actor.y, actor.width, actor.height)

    -- draw food
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(food.mode, food.x, food.y, food.width, food.height)
end

-- Functions    ----------------------------------------------------------------------

function love.keypressed(key)
    actor.direction = key
end

function moveActor(direction)
    
    if direction == "right" then
        newActorPosition(actor, "x", 1)
    elseif direction == "left" then
        newActorPosition(actor, "x", -1)
    elseif direction == "up" then
        newActorPosition(actor, "y", -1)
    elseif direction == "down" then
        newActorPosition(actor, "y", 1)
    end

end

function newActorPosition(obj, axis, direction)
    local actor_x_position = (obj.x / tileWidth) + 1
    local actor_y_position = (obj.y / tileHeight) + 1
    local new_tile = createTileMap("line", obj.x, obj.y, tileWidth, tileHeight, "tile")

    if axis == "x" then
        local actor_map_new_position = actor_x_position + 1 * direction
        local actor_new_position = obj.x + tileWidth * direction
        if actor_new_position < windowWidth and actor_new_position >= 0 then
            if mapOfTiles[actor_map_new_position][actor_y_position].type == "food" then
                foodNewPosition()
            end

            obj.x = actor_new_position
            mapOfTiles[actor_map_new_position][actor_y_position] = obj
            mapOfTiles[actor_x_position][actor_y_position] = new_tile
        end
    else
        local actor_map_new_position = actor_y_position + 1 * direction
        local actor_new_position = obj.y + tileHeight * direction
        if actor_new_position < windowWidth and actor_new_position >= 0  then
            if mapOfTiles[actor_x_position][actor_map_new_position].type == "food" then
                foodNewPosition()
            end

            obj.y = actor_new_position
            mapOfTiles[actor_x_position][actor_map_new_position] = obj
            mapOfTiles[actor_x_position][actor_y_position] = new_tile
        end
    end
end

function foodNewPosition()
    repeat
        local food_x = math.random(0, 5) * tileWidth
        local food_y = math.random(0, 5) * tileHeight
        local food_x_map = food_x / tileWidth + 1
        local food_y_map = food_y / tileHeight + 1

        print("novo x", food_x)
        print("novo y", food_y)
        print("food_x_map ", food_x_map)
        print("food_y_map ", food_y_map)

        if mapOfTiles[food_x_map][food_y_map].type ~= "food" then
            food.x = food_x
            food.y = food_y
            mapOfTiles[food_x / tileWidth + 1][food_y / tileHeight + 1] = food
            break
        end

    until true
end