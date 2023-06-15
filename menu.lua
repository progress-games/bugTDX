local menu = {}

function menu.load()
    if camera == nil then
        camera = Camera()
    end
    sprites = {
        title = Image('title'),
        settings = Image('settings'),
        play = Image('play')
    }

    if #clouds < 5 then
        for i=1, 5 do
            table.insert(clouds, newcloud(math.random(0, world.x)))
        end
    end

    fade = 0
    fading = false

    state = 'menu'
end

function newcloud(x)
    local c = {}
    local y, c, s = math.random(0, world.y), {}, randfloat(todt(0.05), todt(0.25))
    for i=1, math.random(15, 20) do
        local g = math.random(900, 1000)/1000
        table.insert(c, {(x or -100) + math.random(-25, 25), y+math.random(-25, 25), math.random(20, 25), s, g})
    end
    return c
end

function menu.update(dt)
    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale

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
    if not fading and fade < 1 then fade = fade + 0.1 end
    if fading then fade = fade - 0.1 end

    if fade <= 0 then state = nextstate end
    return state
end

function menu.draw()
    camera:attach()
    for _, v in pairs(clouds) do
        for _, c in pairs(v) do
            love.graphics.setColor(c[5], c[5], c[5])
            love.graphics.circle('fill', c[1], c[2], c[3])
        end
    end

    love.graphics.setColor(1, 1, 1, fade)

    languages.update_font('main')

    love.graphics.draw(sprites.title, centre.x-280, centre.y-200, 0, 0.2, 0.2)

    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale

    love.graphics.setColor(0, 0, 0, 0.2*fade)

    if config['language'] ~= 'english' then
        languages.update_font('huge')
        local box = textbox('play', 0, centre.y-5, world.x)
        if x > box.x and x < box.x+box.w and y > box.y and y < box.y+box.h then
            love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        end

        local box = textbox('settings', 0, centre.y+105, world.x)
        if x > box.x and x < box.x+box.w and y > box.y and y < box.y+box.h then
            love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        end

        love.graphics.setColor(1, 1, 1, fade)
        languages.printf('play', 0, centre.y-5, world.x, 'center')
        languages.printf('settings', 0, centre.y+105, world.x, 'center')
    else
        if x > centre.x-150 and x < centre.x-150 + 300 and y > centre.y-10 and y < centre.y-10+80 then
            love.graphics.rectangle('fill', centre.x-150, centre.y-10, 300, 80, 6, 6)
        end
        if x > centre.x-150 and x < centre.x-150 + 300 and y > centre.y+100 and y < centre.y+100+80 then
            love.graphics.rectangle('fill', centre.x-150, centre.y+100, 300, 80, 6, 6)
        end

        love.graphics.setColor(1, 1, 1, fade)
        love.graphics.draw(sprites.play, centre.x-140, centre.y-5, 0, 0.1, 0.1)
        love.graphics.draw(sprites.settings, centre.x-140, centre.y+105, 0, 0.1, 0.1)
    end

    languages.update_font('main')
    love.graphics.setColor(0, 0, 0, 0.2)
    --love.graphics.rectangle('fill', 15, world.y-40, 430, 50, 3, 3)
    
    local box = textboxB('quit game', centre.x-360, centre.y-240)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
    end

    local box = textboxB('discord', 30, world.y-100)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
    end

    local box = textboxB('twitter', 30, world.y-160)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
    end


    local box = textboxB({'music by:', '@creeper4207'}, 30, world.y-40)
    love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
    end

    love.graphics.setColor(1, 1, 1)
    languages.print('discord', 30, world.y-100)
    languages.print('quit game', centre.x-360, centre.y-240)
    languages.print('twitter', 30, world.y-160)

    love.graphics.setColor(1, 1, 1)
    languages.print({'music by:', '@creeper4207'}, 30, world.y-40)



    camera:detach()
    camera:draw()
end

function menu.keypressed(key)
    if key == 'escape' then quit() end
end

function menu.mousepressed()
    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale

    if x > centre.x-150 and x < centre.x-150 + 300 and y > centre.y-10 and y < centre.y-10+80 then
        fading = true
        if config.max_difficulty ~= 0 then
            play('button')
            nextstate = 'change_difficulty'
        else
            play('button')
            nextstate = 'game'
        end
    end
    if x > centre.x-150 and x < centre.x-150 + 300 and y > centre.y+100 and y < centre.y+100+80 then
        play('button')
        fading = true
        nextstate = 'settings'
    end

    local box = textboxB('quit game', centre.x-360, centre.y-240)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        play('button')
        quit()
    end

    local box = textboxB('discord', 30, world.y-100)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        openlink('https://discord.gg/pRjQT8betW')
    end

    local box = textboxB('twitter', 30, world.y-160)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        openlink('https://twitter.com/scalzo_orlando')
    end

    local box = textboxB({'music by:', '@creeper4207'}, 30, world.y-40)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        openlink('https://twitter.com/creeper4207')
    end
end

return menu