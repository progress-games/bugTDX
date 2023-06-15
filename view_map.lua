local view_map = {}

function view_map.load()
    state = 'view_map'
end

function view_map.update(dt)
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

function view_map.draw()
    camera:attach()
    for _, v in pairs(clouds) do
        for _, c in pairs(v) do
            love.graphics.setColor(c[5], c[5], c[5])
            love.graphics.circle('fill', c[1], c[2], c[3])
        end
    end

    love.graphics.setColor(143/255, 86/255, 59/255)
    love.graphics.rectangle('fill', centre.x-32*8-5, centre.y-32*4-5, 16*32+10, 8*32+10)
    love.graphics.setColor(1, 1, 1)

    for i=1, #board do
        for k=1, #board[i] do
            love.graphics.draw(board[i][k].ground, centre.x+32*(i-9), centre.y+32*(k-5))
        end
    end

    for i=1, #board do
        for k=1, #board[i] do
            if board[i][k].obj then
                board[i][k]:draw(x, y)
            end
        end
    end

    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale

    languages.update_font('main')
    local box = textbox('return', 30, 30, 160)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        love.graphics.setColor(1, 1, 1)
    end

    languages.printf('return', 30, 30, 160, 'center')
    camera:detach()
    camera:draw()
end

function view_map.mousepressed()
    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale

    languages.update_font('main')
    local box = textbox('return', 30, 30, 160)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
        state = 'endgame'
    end
end
return view_map