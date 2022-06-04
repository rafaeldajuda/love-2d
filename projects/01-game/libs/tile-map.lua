function createTileMap(mode, x, y, width, height)
    local tile = {
        mode = mode,
        x = x,
        y = y,
        width = width,
        height = height
    }
    return tile
end

function createMap(width, height)
    local listOfTiles = {}
    
    for i=0, 4, 1 do
        local listOfTilesX = {}
        local line = i * width
        for j=0, 4, 1 do 
            local col = j * width
            table.insert(listOfTilesX, createTileMap("line", line, col, width, height))
        end
        table.insert(listOfTiles, listOfTilesX)
    end

    return listOfTiles
end