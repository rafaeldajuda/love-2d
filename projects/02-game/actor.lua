function loadActor(mode, x, y, height, width, speed, life, type) 
    local actor = {
        mode = mode,
        x = x, 
        y = y,
        height = height,
        width = width,
        speed = speed,
        life = life,
        type = type
    }
    return actor
end

function actorDirection(mainActor, dt)
    if love.keyboard.isDown("left") then
        moveActor(mainActor, -1, dt)
    elseif love.keyboard.isDown("right") then
        moveActor(mainActor, 1, dt)
    end
end

function drawActor(mainActor, green)
    love.graphics.setColor(green())
    love.graphics.rectangle(mainActor.mode, mainActor.x, mainActor.y, mainActor.width, mainActor.height)
end

function drawEnemys(listEnemy, red)
    for i, v in ipairs(listEnemy) do
        love.graphics.setColor(red())
        love.graphics.rectangle(v.mode, v.x, v.y, v.width, v.height)
    end
end

function moveActor(actor, direction, dt)
    actor.x = actor.x + (direction*actor.speed) * dt
    actorCollision(actor)
end

function moveEnemy(enemy, enemySpeed, dt) 
    enemy.y = enemy.y + (enemy.speed + enemySpeed)  * dt
end

function actorCollision(actor)
    if actor.x < 0 then
        actor.x = 0
    elseif actor.x > 540 then
        actor.x = 540
    end
end

function enemyBulletCollision(listEnemy, listBullet, dt)
    for i, v in ipairs(listEnemy) do
        moveEnemy(v, enemySpeed, dt)
        bulletCollision(i, v, listBullet)
    end
end

function actorDeath(mainActor, listEnemy)
    if mainActor.life == 0 then
        love.load()
    else
        for i, v in ipairs(listEnemy) do
            if (mainActor.x > v.x and mainActor.x < v.x + 60 and mainActor.y <= v.y + 60) or 
            (mainActor.x + 60 > v.x and mainActor.x + 60 < v.x + 60 and mainActor.y <= v.y + 60) then
                love.load()
            end
        end
    end
end

function createEnemy(listEnemy)
    if #listEnemy < level then
        newX = (love.math.random(1, 10) * 60) - 60
        enemy = loadActor("fill", newX, 0, 60, 60, 75, 3, "enemy")
        table.insert(listEnemy, enemy)
    end
end

function destroyEnemy(listEnemy, mainActor)
    for i, v in ipairs(listEnemy) do
        if v.y >= 600 then
            mainActor.life = mainActor.life -1
            table.remove(listEnemy, i)
        end
    end
end
