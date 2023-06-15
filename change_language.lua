local change_language = {}

function change_language.load()
    fade = 0
    fading = false
    past = current_room
    external_lang = config['language']
    state = 'change_language'
end

function change_language.update(dt)

    for k, v in pairs(clouds) do
        for _, c in pairs(v) do
            c[1] = c[1] + c[4]*dt
            if c[1] > world.x + 100 then
                clouds[k] = newcloud()
            end
        end
    end

    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale

    if not fading and fade < 1 then fade = fade + 0.1 end
    if fading then fade = fade - 0.1 end
    if fade <= 0 then state = 'settings'; config['language'] = external_lang end

    return state
end

function change_language.draw()
    camera:attach()
    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale
    for _, v in pairs(clouds) do
        for _, c in pairs(v) do
            love.graphics.setColor(c[5], c[5], c[5])
            love.graphics.circle('fill', c[1], c[2], c[3])
        end
    end


    local list = languages.get_languages()
    local h1, h2, h3 = {}, {}, {}
    table.move(list, 1, round(#list/3)+1, 1, h1)
    table.move(list, round(#list/3)+2, round((2*#list)/3)+2, 1, h2)
    table.move(list, round((2*#list)/3)+3, #list, 1, h3)

    love.graphics.setColor(0, 0, 0, 0.2)
    love.graphics.rectangle('fill', 40, 25, world.x/3-80, 40*(#list/3-1)+80, 6, 6)
    love.graphics.rectangle('fill', world.x/3+40, 25, world.x/3-80, 40*(#list/3-1)+80, 6, 6)
    love.graphics.rectangle('fill', 2*world.x/3+40, 25, world.x/3-80, 40*(#list/3-2), 6, 6)

    for i=0, 2 do
        for k=0, #list/3 do
            if x > i*world.x/3 + 40 and x < i*world.x/3 + 40 + world.x/3-80 and
            y > 25 + k*40 and y < 25 + (k+1)*40 then
                if i < 2 or i*#list/3 + 3 + k <= #list then
                    love.graphics.rectangle('fill', i*world.x/3 + 40, 25 + k*40, world.x/3-80, 40, 6, 6)
                end
            end
        end
    end

    languages.update_font('main')
    love.graphics.setColor(1, 1, 1)

    for i, v in pairs(h1) do
        config['language'] = v
        languages.update_font('main')
        languages.printf(v, 0, 40*(i-1)+30, world.x/3, 'center')
    end
    for i, v in pairs(h2) do
        config['language'] = v
        languages.update_font('main')
        languages.printf(v, world.x/3, 40*(i-1)+30, world.x/3, 'center')
    end
    for i, v in pairs(h3) do
        config['language'] = v
        languages.update_font('main')
        languages.printf(v, 2*world.x/3, 40*(i-1)+30, world.x/3, 'center')
    end

    config['language'] = external_lang
    languages.update_font('settings')
    local box = textbox('return', 0, world.y-55, world.x)

    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 6, 6)
        love.graphics.setColor(1, 1, 1)
    end


    languages.printf('return', 0, world.y-50, world.x, 'center')
    
    camera:detach()
    camera:draw()
end

function change_language.mousepressed()
    local list = languages.get_languages()

    for i=0, 2 do
        for k=0, #list/3 do
            if x > i*world.x/3 + 40 and x < i*world.x/3 + 40 + world.x/3-80 and
            y > 25 + k*40 and y < 25 + (k+1)*40 then
                if i < 2 or k + 1 < round(#list/3) then
                    if i == 0 then
                        play('button')
                        external_lang = list[round(i*(#list/3)+k)+1]
                    elseif i == 1 then
                        play('button')
                        external_lang = list[round(i*(#list/3)+k)+2]
                    else
                        play('button')
                        external_lang = list[round(i*(#list/3)+k)+3]
                    end
                end
            end
        end
    end


    local box = textbox('return', 0, world.y-55, world.x)

    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        play('button')
        config['language'] = external_lang
        fading = true
    end
end

return change_language