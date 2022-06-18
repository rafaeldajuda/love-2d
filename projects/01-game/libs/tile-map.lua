function createTileMap(mode, x, y, width, height, type)
    local tile = {
        mode = mode,
        x = x,
        y = y,
        width = width,
        height = height,
        type = type
    }
    return tile
end

function createMap(width, height)
    local listOfTiles = {}

    for i = 0, 4, 1 do
        local listOfTilesX = {}
        local line = i * width
        for j = 0, 4, 1 do
            local col = j * width
            table.insert(listOfTilesX, createTileMap("line", line, col, width, height, "tile"))
        end
        table.insert(listOfTiles, listOfTilesX)
    end

    return listOfTiles
end

function printMap(map)
    for i = 1, tablelength(map), 1 do
        for j = 1, tablelength(map), 1 do
            print(i, j, map[i][j].type)
        end
    end
    print("/-------------------------/")
end
