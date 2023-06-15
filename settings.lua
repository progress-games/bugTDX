local settings = {}


function settings.load()
    fade = 0
    fading = false
    if current_room ~= 'change_language' then
        past = current_room
    elseif started then
        past = 'game'
    else
        past = 'menu'
    end
    state = 'settings'
end

function settings.update(dt)
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
    else
        camera.x, camera.y = window.x/2, window.y/2
    end

    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale

    if not fading and fade < 1 then fade = fade + 0.1 end
    if fading then fade = fade - 0.1 end
    if fade <= 0 then state = past end

    return state
end

function save_settings()
    print('settings are being saved')
    lines = {}
    for name, val in pairs(config) do
        table.insert(lines, name..':'..tostring(val))
        print(name..':'..tostring(val))
    end
    print(lines[0])

    file.write('settings.txt', lines)
end

function settings.draw()
    camera:attach()
    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale
    for _, v in pairs(clouds) do
        for _, c in pairs(v) do
            love.graphics.setColor(c[5], c[5], c[5])
            love.graphics.circle('fill', c[1], c[2], c[3])
        end
    end

    love.graphics.setColor(0, 0, 0, 0.2*fade)
    love.graphics.rectangle('fill', centre.x-200, centre.y-200, 400, 400, 6, 6)

    if x > centre.x-130 and x < centre.x-130+300 and y > centre.y+60 and y < centre.y+110 then
        love.graphics.rectangle('fill', centre.x-130, centre.y+60, 300, 50, 6, 6)
    end

    languages.update_font('main')
    love.graphics.setColor(1, 1, 1, fade)
    languages.print({'sfx volume:', config.sfx*10}, centre.x-180, centre.y-180)
    languages.print({'music volume:', config.music*10}, centre.x-180, centre.y-130)
    languages.printf({'ui scaling:', (config.ui)..'%'}, centre.x-180, centre.y-80, 250)
    languages.print('camera:', centre.x-180, centre.y+20)
    languages.printf('change language', centre.x-180, centre.y+70, 400, 'center')

    languages.update_font('settings')
    for i=0, 2 do
        love.graphics.setColor(0, 0, 0, 0.2*fade)
        if x > centre.x+100 - 2 and x < centre.x+100 + 30 - 2 and y > centre.y-145+(i-1)*50 + 10-2 and y < centre.y-145+(i-1)*50 + 40-2 then
            love.graphics.rectangle('fill', centre.x+100 - 2, centre.y-145+(i-1)*50 + 10-2, 30, 30, 3, 3)
        end

        if x > centre.x+150 - 2 and x < centre.x+150 + 30 - 4 and y > centre.y-145+(i-1)*50 + 10-4 and y < centre.y-145+(i-1)*50 + 40-2 then
            love.graphics.rectangle('fill', centre.x+150 - 4, centre.y-145+(i-1)*50 + 10-2, 30, 30, 3, 3)
        end

        love.graphics.setColor(1, 1, 1, fade)
        love.graphics.setFont(font.english.settings)
        love.graphics.print('+', centre.x+100, centre.y-145+(i-1)*50)
        love.graphics.print('-', centre.x+150, centre.y-145+(i-1)*50)
    end

    languages.update_font('main')

    love.graphics.setColor(1, 1, 1, fade)
    if config['camera'] then
        local box = textboxB('on', centre.x+115, centre.y+20)
        if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
            love.graphics.setColor(0, 0, 0, 0.2*fade)
            love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        end

        love.graphics.setColor(1, 1, 1, fade)
        languages.print('on', centre.x + 115, centre.y+20)
    else

        local box = textboxB('off', centre.x+115, centre.y+20)
        if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
            love.graphics.setColor(0, 0, 0, 0.2*fade)
            love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        end

        love.graphics.setColor(1, 1, 1, fade)
        languages.print('off', centre.x + 115, centre.y+20)
    end

    languages.update_font('settings')

    local box = textbox('return', centre.x-200, centre.y+140, 400)

    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        love.graphics.setColor(0, 0, 0, 0.2*fade)
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        love.graphics.setColor(1, 1, 1, fade)
    end

    languages.printf('return', centre.x-200, centre.y+140, 400, 'center')

    if past ~= 'menu' then
        local box = textbox('return to main menu', 0, centre.y+210, world.x)

        if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
            love.graphics.setColor(0, 0, 0, 0.2*fade)
            love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
            love.graphics.setColor(1, 1, 1, fade)
        end
        languages.printf('return to main menu', 0, centre.y+210, world.x, 'center')
    end

    languages.update_font('main')
    love.graphics.setColor(0, 0, 0, 0.2)

    local box = textboxB({'music by:', '@creeper4207'}, 30, world.y-40)
    love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)

    love.graphics.setColor(1, 1, 1)
    languages.print({'music by:', '@creeper4207'}, 30, world.y-40)

    languages.printf('user interface size cannot be changed during battle', 0, 20, world.x, 'center')
    camera:detach()
    camera:draw()
end

function settings.keypressed(key)
    if key == 'escape' then fading = true end
end

function settings.mousepressed()
    local actions = {
        function (sign)
            config['sfx'] = config['sfx'] + sign*0.1
            if config['sfx'] < 0.05 then config['sfx'] = 0 elseif config['sfx'] > 0.95 then config['sfx'] = 1 end
            for _, v in pairs(audio.sfx) do v:setVolume(config['sfx']) end
        end,
        function (sign)
            config['music'] = config['music'] + sign*0.1
            if config['music'] < 0.05 then config['music'] = 0 elseif config['music'] > 0.95 then config['music'] = 1 end
            for _, v in pairs(audio.music) do v:setVolume(config['music']) end
        end,
        function (sign)
            if past == 'game' then return nil end
            config['ui'] = config['ui'] + 10*sign
            if config['ui'] < 40 then config['ui'] = 40 end
            if config['ui'] > 300 then config['ui'] = 300 end
            window.scale = config['ui']/100
            world = {
                x = window.x/window.scale,
                y = window.y/window.scale
            }
            centre = {
                x = world.x/2,
                y = world.y/2
            }
            love.graphics.setDefaultFilter('nearest', 'nearest')
            canvas = love.graphics.newCanvas(window.x/window.scale, window.y/window.scale)
        end
    }
    for i=0, 2 do
        if x > centre.x+100 - 2 and x < centre.x+100 + 30 - 2 and y > centre.y-145+(i-1)*50 + 10-2 and y < centre.y-145+(i-1)*50 + 40-2 then
            actions[i+1](1)
            play('button')
        end

        if x > centre.x+150 - 2 and x < centre.x+150 + 30 - 4 and y > centre.y-145+(i-1)*50 + 10-4 and y < centre.y-145+(i-1)*50 + 40-2 then
            actions[i+1](-1)
            play('button')
        end
    end

    if x > centre.x-195 and x < centre.x-195 + 385 and y > centre.y+135 and y < centre.y+135 + 54 then
        fading = true
        play('button')
    end

    languages.update_font('settings')
    local box = textbox('return to main menu', 0, centre.y+210, world.x)

    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        state = 'menu'
        started = false
    end

    languages.update_font('main')

    if config['camera'] then
        box = textboxB('on', centre.x+115, centre.y+20)
    else
        box = textboxB('off', centre.x+115, centre.y+20)
    end

    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        play('button')
        config['camera'] = not config['camera']
    end

    if x > centre.x-130 and x < centre.x-130+300 and y > centre.y+60 and y < centre.y+110 then
        play('button')
        state = 'change_language'
    end
end

return settings