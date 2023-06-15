local lightning = {}

function lightning.newchain(index, range, max, stats)
    local x, y = enemies[index].x, enemies[index].y
    local newchain = {
        hit = {index},
        timer = 0.3
    }
    local dist = {index, 10000}

    for _=1, max do

        for i, v in pairs(enemies) do
            if not intable(newchain.hit, i) and math.sqrt((x-v.x)^2+(y-v.y)^2) < dist[2] and math.sqrt((x-v.x)^2+(y-v.y)^2) <= range then
                dist = {i, math.sqrt((x-v.x)^2+(y-v.y)^2)}
            end
        end

        if dist[1] ~= index then
            table.insert(newchain.hit, dist[1])
            enemies[dist[1]]:takedmg(stats.dmg, 'shock', stats)
            dist = {index, 10000}
        end
    end

    if #newchain.hit ~= 1 then
        table.insert(chains, newchain)
    end
end

function lightning.load()
    chains = {}
end

function lightning.update(dt)
    for i, v in pairs(chains) do
        v.timer = v.timer - dt
        if v.timer <= 0 then
            table.remove(chains, i)
        end
    end
end

function lightning.adjust(index)
    for k, v in pairs(chains) do
        for i, n in ipairs(v.hit) do
            if n == index then table.remove(v.hit, i)
            elseif n > index then v.hit[i] = v.hit[i] - 1 end
        end
        if #v.hit <= 1 then
            --love.event.quit()
            table.remove(chains, k)
        end
    end
end

function lightning.draw()
    love.graphics.setColor(1, 1, 0)
    for _, v in pairs(chains) do
        for i, n in pairs(v.hit) do
            if #v.hit >= i+1 then
                if enemies[v.hit[i+1]] and enemies[n] then
                    local dis = math.sqrt((enemies[n].x-enemies[v.hit[i+1]].x)^2+(enemies[n].y-enemies[v.hit[i+1]].y)^2)
                    local sx, sy = enemies[n].x, enemies[n].y
                    for _=1, dis*1.5 do
                        local dir = math.atan2(sy-enemies[v.hit[i+1]].y, sx-enemies[v.hit[i+1]].x) + torad(math.random(-100, 100)) + math.pi
                        local tx, ty = sx+math.cos(dir), sy+math.sin(dir)
                        love.graphics.line(sx, sy, tx, ty)
                        sx, sy = tx, ty
                    end
                    love.graphics.line(sx, sy, enemies[v.hit[i+1]].x, enemies[v.hit[i+1]].y)
                end
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
end

return lightning