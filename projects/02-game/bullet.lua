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