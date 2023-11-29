function love.load() 
    -- imports
    require "actor"
    require "bullet"

    -- colors
    red = function () return 255, 0, 0 , 1 end
    green = function () return 0, 255, 0 , 1 end
    white =  function () return 255, 255, 255 , 1 end

    -- window
    love.window.setTitle("meteor shoot")
    love.window.setMode(600, 600, nil)

    -- others
    mainActor = loadActor("fill", 0, 540, 60, 60, "main")
    actorDirection = "right"

    listEnemy = {}
    listBullet = {}

    time = 0
    bulletTime = 0
end

function love.update(dt)
    -- actor
    if love.keyboard.isDown("left") then
        moveActor("left", dt)
    elseif love.keyboard.isDown("right") then
        moveActor("right", dt)
    end

    -- enemy
    for i, v in ipairs(listEnemy) do
        moveEnemy(v, dt)
        bulletCollision(i, v, listBullet)
    end

    -- bullet
    for i, v in ipairs(listBullet) do
        v.y = v.y - 1000 * dt
        -- destroy
        if v.y <= 0 then
            table.remove(listBullet, i)
        end
    end

    destroyEnemy()
    actorDeath()

    -- log
    time = time + dt
    bulletTime = bulletTime + dt
    if time >= 1 then
        createEnemy()

        time = 0
        print("/--------------/")
        print("listBullet", #listBullet)
        for i, v in ipairs(listEnemy) do
            print("enemy x", v.x)
            print("enemy y", v.y)
        end
    end
end

function love.draw()
    -- actor
    love.graphics.setColor(green())
    love.graphics.rectangle(mainActor.mode, mainActor.x, mainActor.y, mainActor.width, mainActor.height)

     -- bullets
     for i, v in ipairs(listBullet) do
        love.graphics.setColor(white())
        love.graphics.rectangle(v.mode, v.x, v.y, v.width, v.height, 1)
    end

    -- enemys
    for i, v in ipairs(listEnemy) do
        love.graphics.setColor(red())
        love.graphics.rectangle(v.mode, v.x, v.y, v.width, v.height)
    end

end

-- other functions

function love.keypressed(key, scancode, isrepeat)
    if key == "space" and bulletTime >= 0.1 then
        bulletTime = 0
        bulletX = mainActor.x + 25
        bullet = createBullet("fill", bulletX, 540, 10, 10)
        table.insert(listBullet, bullet)
    end
end

function moveActor(direction, dt)
    if direction == "left"  then
        mainActor.x = mainActor.x - 240 * dt
    elseif direction == "right" then
        mainActor.x = mainActor.x + 240 * dt
    end 
    actorCollision(mainActor)
end

function moveEnemy(enemy, dt) 
    enemy.y = enemy.y + 75 * dt
end

function actorCollision(mc)
    if mc.x < 0 then
        mc.x = 0
    elseif mc.x > 540 then
        mc.x = 540
    end
end

function bulletCollision(index, enemy)
    for i, v in ipairs(listBullet) do
        if v.x > enemy.x and v.x < enemy.x + 60 and v.y <= enemy.y + 60 then
            table.remove(listEnemy, index)
            table.remove(listBullet, i)
        end
    end
end

function createEnemy()
    if #listEnemy < 1 then
        newX = (love.math.random(1, 10) * 60) - 60
        enemy = loadActor("fill", newX, 0, 60, 60, "enemy")
        table.insert(listEnemy, enemy)
    end
end

function destroyEnemy()
    for i, v in ipairs(listEnemy) do
        if v.y >= 600 then
            table.remove(listEnemy, i)
        end
    end
end

function actorDeath()
    for i, v in ipairs(listEnemy) do
        if (mainActor.x > v.x and mainActor.x < v.x + 60 and mainActor.y <= v.y + 60) or 
        (mainActor.x +60 > v.x and mainActor.x +60 < v.x + 60 and mainActor.y <= v.y + 60) then
            love.load()
        end
    end
end
