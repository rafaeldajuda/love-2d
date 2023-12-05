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
    mainActor = loadActor("fill", 0, 540, 60, 60, 240, 3, "main")

    listEnemy = {}
    listBullet = {}

    time = 0
    bulletTime = 0
    points = 0
    level = 1
    enemySpeed = 0
end

function love.update(dt)
    -- actor
    if love.keyboard.isDown("left") then
        moveActor(mainActor, -1, dt)
    elseif love.keyboard.isDown("right") then
        moveActor(mainActor, 1, dt)
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
    actorDeath(mainActor, listEnemy)

    -- log
    time = time + dt
    bulletTime = bulletTime + dt
    if time >= 1 then
        createEnemy()

        time = 0
        print("/--------------/")
        print("points", points)
        print("level", level)
        print("enemySpeed", enemySpeed)
        print("life", mainActor.life)
        print("listBullet", #listBullet)
        for i, v in ipairs(listEnemy) do
            print(i.."-enemy x", v.x)
            print(i.."-enemy y", v.y)
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

function moveEnemy(enemy, dt) 
    enemy.y = enemy.y + (enemy.speed + enemySpeed)  * dt
end

function bulletCollision(index, enemy)
    for i, v in ipairs(listBullet) do
        if v.x > enemy.x and v.x < enemy.x + 60 and v.y <= enemy.y + 60 or 
        v.x + 10 > enemy.x and v.x + 10 < enemy.x + 60 and v.y <= enemy.y + 60 then
            points, enemySpeed = addPoint(points, enemySpeed)
            table.remove(listEnemy, index)
            table.remove(listBullet, i)
        end
    end
end

function createEnemy()
    if #listEnemy < level then
        newX = (love.math.random(1, 10) * 60) - 60
        enemy = loadActor("fill", newX, 0, 60, 60, 75, 3, "enemy")
        table.insert(listEnemy, enemy)
    end
end

function destroyEnemy()
    for i, v in ipairs(listEnemy) do
        if v.y >= 600 then
            mainActor.life = mainActor.life -1
            table.remove(listEnemy, i)
        end
    end
end
