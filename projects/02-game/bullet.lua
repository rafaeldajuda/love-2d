function createBullet(mode, x, y, height, width)
    local bullet = {
        mode = mode,
        x = x, 
        y = y,
        height = height,
        width = width,
    }
    return bullet
end

function addPoint(points, enemySpeed) 
    points = points + 1
    enemySpeed = updateLevel(points, enemySpeed)
    return points, enemySpeed
end

function updateLevel(points, enemySpeed) 
    if points % 10 == 0 then
        level = level + 1
        enemySpeed = enemySpeed + 25
    end
    return enemySpeed
end

function shoot(key, bulletTime, mainActor, listBullet)
    if key == "space" and bulletTime >= 0.1 then
        bulletTime = 0
        bulletX = mainActor.x + 25
        bullet = createBullet("fill", bulletX, 540, 10, 10)
        table.insert(listBullet, bullet)
    end
end

function moveBullet(listBullet, dt)
    for i, v in ipairs(listBullet) do
        v.y = v.y - 1000 * dt
        -- destroy
        if v.y <= 0 then
            table.remove(listBullet, i)
        end
    end
end

function bulletCollision(indexEnemy, enemy, listBullet)
    for i, v in ipairs(listBullet) do
        if v.x > enemy.x and v.x < enemy.x + 60 and v.y <= enemy.y + 60 or 
        v.x + 10 > enemy.x and v.x + 10 < enemy.x + 60 and v.y <= enemy.y + 60 then
            points, enemySpeed = addPoint(points, enemySpeed)
            table.remove(listEnemy, indexEnemy)
            table.remove(listBullet, i)
        end
    end
end

