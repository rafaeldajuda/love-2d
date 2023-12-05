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