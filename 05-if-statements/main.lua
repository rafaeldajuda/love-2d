function love.load()
    x = 100
end

function love.update(dt)
    if x < 600 then
        x = x + 100 * dt
    end
end

function love.draw()
    love.graphics.rectangle("line", x, 50, 200, 150)
end

if true then print(1) end --Not false or nil, executes.
if false then print(2) end --False, doesn't execute.
if nil then print(3) end --Nil, doesn't execute
if 5 then print(4) end --Not false or nil, executes
if "hello" then print(5) end --Not false or nil, executes
--Output: 1, 4, 5