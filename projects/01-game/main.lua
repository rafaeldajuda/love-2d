require("libs.tile-map")
require("libs.others-functions")

function love.load()
    love.window.setTitle("snake game")
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

    -- SubActors
    listActors = {}
    table.insert(listActors, actor)

    -- Food
    newFood = true
    food = createTileMap("fill", 0, 0, tileWidth, tileHeight, "food")
    foodNewPosition()

    time = 0
end

function love.update(dt)

    time = time + dt
    if time >= 1 then
        moveActor(actor.direction)
        foodNewPosition()

        print("direction", actor.direction)
        print("actor_x", actor.x)
        print("actor_y", actor.y)
        print("/-------------------------/")
    end

end

function love.draw()

    -- print mapOfTiles
    -- for i, line in ipairs(mapOfTiles) do
    --     for j, tile in ipairs(line) do
    --         love.graphics.setColor(1, 1, 1)
    --         love.graphics.rectangle(tile.mode, tile.x, tile.y, tile.width, tile.height)
    --     end
    -- end

    -- print actors
    for i, ac in ipairs(listActors) do
        -- print actor
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle(ac.mode, ac.x, ac.y, ac.width, ac.height)
    end

    -- print food
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(food.mode, food.x, food.y, food.width, food.height)

    

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
    local actor_x = actor.x
    local actor_y = actor.y
    time = 0

    if axis == "x" then
        local new_actor_x = actor_x + tileWidth * direction

        -- se estiver dentro da tela
        if new_actor_x >= 0 and new_actor_x < windowWidth then
            actor.x = new_actor_x

            eatFood()

            if newFood then
                newSubActor()
            end

            subActorsPosition(actor_x, actor_y, 2)
            if actorBitHimself(new_actor_x, actor_y) then
                gameOver()
            end

        else
            gameOver()
        end

    elseif axis == "y" then
        local new_actor_y = actor_y + tileWidth * direction

        -- se estiver dentro da tela
        if new_actor_y >= 0 and new_actor_y < windowHeight then
            actor.y = new_actor_y
            
            eatFood()
            if newFood then
                newSubActor()
            end

            subActorsPosition(actor_x, actor_y, 2)
            if actorBitHimself(actor_x, new_actor_y) then
                gameOver()
            end

        else
            gameOver()
        end

    end
end

function gameOver()
    print("game over")
    love.load()
end

function eatFood()
    if food.x == actor.x and food.y == actor.y then
        newFood = true
    end
end

function foodNewPosition()

    while newFood do
        print("nova comida")
        local food_x = math.random(0, 4) * tileWidth
        local food_y = math.random(0, 4) * tileHeight
        local valid_position = true

        for i, ac in ipairs(listActors) do
            if ac.x ==  food_x and ac.y == food_y then
                valid_position = false
                break
            end
        end

        if valid_position then
            food.x = food_x
            food.y = food_y
            newFood = false
        end
    end

end

function newSubActor()
    local new_actor = createTileMap("fill", 0, 0, tileWidth, tileHeight, "actor")
    table.insert(listActors, new_actor)
end

function subActorsPosition(newPosX, newPosY, actorPosition)
    if tablelength(listActors) ~= 1 and tablelength(listActors) >= actorPosition then
        local old_pos_x = listActors[actorPosition].x
        local old_pos_y = listActors[actorPosition].y
        local new_actor_position = actorPosition + 1
        listActors[actorPosition].x = newPosX
        listActors[actorPosition].y = newPosY
        subActorsPosition(old_pos_x, old_pos_y, new_actor_position)
    end
end

function actorBitHimself(posPox, posY)
    if tablelength(listActors) > 1 then
        for i=2, tablelength(listActors), 1 do
            if actor.x == listActors[i].x and actor.y == listActors[i].y then
                return true
            end
        end
    end
   
    return false
end