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

function moveActor(actor, direction, dt)
    actor.x = actor.x + (direction*actor.speed) * dt
    actorCollision(actor)
end

function actorCollision(actor)
    if actor.x < 0 then
        actor.x = 0
    elseif actor.x > 540 then
        actor.x = 540
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