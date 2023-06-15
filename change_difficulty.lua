local change_difficulty = {}

function change_difficulty.load()
    state = 'change_difficulty'

end

function change_difficulty.update(dt)

    for k, v in pairs(clouds) do
        for _, c in pairs(v) do
            c[1] = c[1] + c[4]*dt
            if c[1] > world.x + 100 then
                clouds[k] = newcloud()
            end
        end
    end

    wavetowers = difficulty[config.difficulty+1].towers
    return state
end

function change_difficulty.draw()
    camera:attach()
    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale
    for _, v in pairs(clouds) do
        for _, c in pairs(v) do
            love.graphics.setColor(c[5], c[5], c[5])
            love.graphics.circle('fill', c[1], c[2], c[3])
        end
    end

    love.graphics.setColor(0, 0, 0, 0.2)
    love.graphics.rectangle('fill', centre.x-325, 30, 650, centre.y+10, 3, 3)

    love.graphics.setFont(font.english.settings)
    local gap = 20
    for i=0, config.max_difficulty do
        if config.max_difficulty % 2 == 0 then
            --there's an odd number
            if x > centre.x-32+(round(i-config.max_difficulty/2))*(64+gap) and x < centre.x-32+(round(i-config.max_difficulty/2))*(64+gap) + 64
            and y > centre.y + 60 and y < centre.y + 64 +60  then
                love.graphics.setColor(0, 0, 0, 0.2)
                love.graphics.rectangle('fill', centre.x-32+(round(i-config.max_difficulty/2))*(64+gap), centre.y+60, 64, 64, 3, 3)
            end

            love.graphics.setColor(0, 0, 0, 0.2)
            love.graphics.rectangle('fill', centre.x-32+(round(i-config.max_difficulty/2))*(64+gap), centre.y+60, 64, 64, 3, 3)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(i, centre.x-32+(round(i-config.max_difficulty/2))*(64+gap)+20, centre.y+70)
        else
            --there's an even number
            if x > centre.x-64-gap/2+(round(i-config.max_difficulty/2))*(64+gap) and x < centre.x-64-gap/2+(round(i-config.max_difficulty/2))*(64+gap) + 64
            and y > centre.y+60 and y < centre.y +60 + 64 then
                love.graphics.setColor(0, 0, 0, 0.2)
                love.graphics.rectangle('fill', centre.x-64-gap/2+(round(i-config.max_difficulty/2))*(64+gap), centre.y+60, 64, 64, 3, 3)
            end

            love.graphics.setColor(0, 0, 0, 0.2)
            love.graphics.rectangle('fill', centre.x-64-gap/2+(round(i-config.max_difficulty/2))*(64+gap), centre.y+60, 64, 64, 3, 3)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(i, centre.x-64-gap/2+(round(i-config.max_difficulty/2))*(64+gap)+20, centre.y+70)

        end
    end

    languages.update_font('main')

    languages.printf({'difficulty level', config.difficulty}, centre.x-300, 40, 600, 'center')

    for i, v in pairs(difficulty[config.difficulty+1].desc) do
        if type(v[2]) ~= 'table' then
            languages.print({v[1], v[2]}, centre.x-300, 60 + 30*i, ':')
        else
            local items = {}
            for k, item in pairs(v[2]) do
                if intable(translations, item) then
                    table.insert(items, translations[item][config.language])
                else
                    table.insert(items, item)
                end
            end
            languages.printf({v[1], table.concat(items, ', ')}, centre.x-300, 60 + 30*i, 600, 'left', ':')
            
        end
    end

    if config['language'] ~= 'english' then
        languages.update_font('huge')
        love.graphics.setColor(0, 0, 0, 0.2)
        local box = textbox('play', 0, centre.y-5+160, world.x)
        if x > box.x and x < box.x+box.w and y > box.y and y < box.y+box.h then
            love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        end

        love.graphics.setColor(1, 1, 1)

        languages.printf('play', 0, centre.y-5+160, world.x, 'center')
    else
        love.graphics.setColor(0, 0, 0, 0.2)
        if x > centre.x-150 and x < centre.x-150 + 300 and y > centre.y-10+170 and y < centre.y-10+80+170 then
            love.graphics.rectangle('fill', centre.x-150, centre.y-10+170, 300, 80, 6, 6)
        end

        love.graphics.setColor(1, 1, 1)

        love.graphics.draw(sprites.play, centre.x-140, centre.y+170, 0, 0.1, 0.1)
    end

    languages.update_font('settings')
    local box = textbox('return', 0, centre.y+260, 300)
    love.graphics.setColor(0, 0, 0, 0.2)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
    end

    love.graphics.setColor(1, 1, 1)
    languages.printf('return', 0, centre.y+260, 300, 'center')

    camera:detach()
    camera:draw()
end

function change_difficulty.mousepressed()
    local gap = 20
    for i=0, config.max_difficulty do
        if config.max_difficulty % 2 == 0 then
            if x > centre.x-32+(round(i-config.max_difficulty/2))*(64+gap) and x < centre.x-32+(round(i-config.max_difficulty/2))*(64+gap) + 64
            and y > centre.y + 60 and y < centre.y + 64 +60  then
                play('button')
                config.difficulty = i
            end
        else
            if x > centre.x-64-gap/2+(round(i-config.max_difficulty/2))*(64+gap) and x < centre.x-64-gap/2+(round(i-config.max_difficulty/2))*(64+gap) + 64
            and y > centre.y+60 and y < centre.y +60 + 64 then
                play('button')
                config.difficulty = i
            end
        end
    end

    if config['language'] ~= 'english' then
        local box = textbox('play', 0, centre.y-5+160, world.x)
        if x > box.x and x < box.x+box.w and y > box.y and y < box.y+box.h then
            play('button')
            state = 'game'
        end
    else
        if x > centre.x-150 and x < centre.x-150 + 300 and y > centre.y-10+170 and y < centre.y-10+80+170 then
            play('button')
            state = 'game'
        end
    end

    languages.update_font('settings')
    local box = textbox('return', 0, centre.y+260, 300)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        play('button')
        state = 'menu'
    end
    
    update_towers()
end

return change_difficulty