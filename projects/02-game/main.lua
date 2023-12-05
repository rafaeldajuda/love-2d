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

    enemyBulletCollision(listEnemy, listBullet, dt)
    moveBullet(listBullet, dt)
    destroyEnemy(listEnemy, mainActor)
    actorDeath(mainActor, listEnemy)

    -- log
    time = time + dt
    bulletTime = bulletTime + dt
    if time >= 1 then
        createEnemy(listEnemy)

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

function love.keypressed(key)
    shoot(key, bulletTime, mainActor, listBullet)
end
