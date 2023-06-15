local endgame = {}

function endgame.load()
    if config.difficulty == config.max_difficulty and config.max_difficulty ~= 4 and pass ~= 0 then
        config.max_difficulty = config.max_difficulty + 1
        showdifficulty = true
    else
        showdifficulty = false
    end

    if pass > 0 then
        steam.userStats.setAchievement('VICTORY')
        steam.userStats.storeStats()
        local pesticide_used = false
        local all_t5 = true
        for i=1, #board do
            for k=1, #board[i] do
                if board[i][k].obj then
                    if board[i][k].name == 'pesticide' then
                        pesticide_used = true
                    end
                    if board[i][k].tier ~= 5 then
                        all_t5 = false
                    end
                end
            end
        end
        if config.difficulty == 4 then
            steam.userStats.setAchievement('VICTORY +')
            steam.userStats.storeStats()
            if not pesticide_used then
                steam.userStats.setAchievement('BUILT DIFFERENT')
                steam.userStats.storeStats()
            end
        end
        if not damage_taken then
            steam.userStats.setAchievement('PRECISE')
            steam.userStats.storeStats()
        end
        if all_t5 then
            steam.userStats.setAchievement('ADVANCED TECHNOLOGY')
            steam.userStats.storeStats()
        end
    else
        steam.userStats.setAchievement('FAILURE')
        steam.userStats.storeStats()
    end

    addicted_timer = 0

    state = 'endgame'
end

function endgame.update(dt)
    addicted_timer = addicted_timer + dt
    for k, v in pairs(clouds) do
        for _, c in pairs(v) do
            c[1] = c[1] + c[4]*dt
            if c[1] > world.x + 100 then
                clouds[k] = newcloud()
            end
        end
    end

    if config['camera'] then
        camera.x = window.x/2 + (mouse.x-centre.x)/12
        camera.y = window.y/2 + (mouse.y-centre.y)/12
    end

    return state
end

function endgame.draw()
    camera:attach()
    love.graphics.setColor(1, 1, 1)
    for _, v in pairs(clouds) do
        for _, c in pairs(v) do
            love.graphics.setColor(c[5], c[5], c[5])
            love.graphics.circle('fill', c[1], c[2], c[3])
        end
    end

    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale
    local gap = 20
    local towers = {}

    for i=1, math.ceil(#towerpos/8) do
        towers[i] = {}
        table.move(towerpos, (i-1)*8+1, i*8, 1, towers[i])
    end

    for vert, towerlist in pairs(towers) do
        for k, v in pairs(towerlist) do
            local i = k
            local rx, ry = 0, 0
            local sprite = board[v[1]][v[2]].sprite

            if #towerlist % 2 == 1 then
                i = i - 1
                rx, ry = centre.x-32+(round(i-#towerlist/2))*(64+gap), centre.y-40
            else
                rx, ry = centre.x-64-gap/2+(round(i-#towerlist/2))*(64+gap), centre.y-40
            end

            ry = ry + (vert-1)*(64+gap)

            love.graphics.setColor(0, 0, 0, 0.2)
            love.graphics.rectangle('fill', rx, ry, 64, 64, 3, 3)

            if x > rx and x < rx + 64 and y > ry and y < ry + 64 then
                love.graphics.rectangle('fill', rx, ry, 64, 64, 3, 3)
            end

            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(sprite, rx+6, ry+6, 0, 1.5, 1.5)
        end
    end

    languages.update_font('huge')
    local f = love.graphics.getFont()
    local h = 0

    if pass > 0 then
        languages.outlinef('YOU WIN', 0, 150, world.x, 2)
        local h = f:getHeight(translations['YOU WIN'][config.language])
    else
        languages.outlinef('GAME OVER', 0, 150, world.x, 2)
        local h = f:getHeight(translations['GAME OVER'][config.language])
    end

    h = h+70
    languages.update_font('main')
    languages.printf({'difficulty level', config.difficulty}, 0, 150+h+5, world.x, 'center', ' ')

    local box = textbox('view map', 30, 30, 160)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        love.graphics.setColor(1, 1, 1)
    end
    languages.printf('view map', 30, 30, 160, 'center')
    
    languages.printf({'thanks for playing!', ':)'}, 0, world.y-50, world.x, 'center')

    if showdifficulty then
        local box = textboxB({'unlocked difficulty level', config.max_difficulty}, 10, world.y-50-45)
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        love.graphics.setColor(1, 1, 1)
        languages.print({'unlocked difficulty level', config.max_difficulty}, 10, world.y-50-45, ' ')
    end

    languages.update_font('settings')
    local box = textbox('return', 0, world.y-150, world.x)
    if x > box.x and x < box.x+box.w and y > box.y and y < box.y+box.h then
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        love.graphics.setColor(1, 1, 1)
    end
    languages.printf('return', 0, world.y-150, world.x, 'center')
    camera:detach()
    camera:draw()
end

function endgame.keypressed(key)
    if key == 'escape' then state = 'menu'; started = false end
end

function endgame.mousepressed()
    languages.update_font('settings')
    local box = textbox('return', 0, world.y-150, world.x)
    if x > box.x and x < box.x+box.w and y > box.y and y < box.y+box.h then
        state = 'menu'
        started = false
    end

    languages.update_font('main')
    local box = textbox('view map', 30, 30, 160)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        state = 'view_map'
    end
end

return endgame