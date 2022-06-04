function love.load()
    fruits = {"apple", "banana"}
    table.insert(fruits, "pear")
    table.insert(fruits, "pineapple")
    table.remove(fruits, 2)
    fruits[1] = "tomato"

    for i, v in ipairs(fruits) do 
        print(i, v)
    end
end

function love.update()

end

function love.draw()

    for i,frt in ipairs(fruits) do
        love.graphics.print(frt, 100, 100 + 50 * i)     
    end
end
