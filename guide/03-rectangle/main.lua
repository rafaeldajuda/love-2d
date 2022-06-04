function love.load()
   
end

function love.update()

end

function love.draw()
    love.graphics.print("rectangle")
    love.graphics.rectangle("fill", 10, 20, 100, 100)   
    love.graphics.rectangle("line", 120, 20, 100, 100) 
end
