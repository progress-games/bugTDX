local shop = Object:extend()

function shop:new(tier)
    self.tier = tier
    self.selection = {}
    for k, v in pairs(names) do
        if v.tier <= self.tier then
            table.insert(self.selection, k)
        end
    end
    self.spaces = 3
    self.bought = {false, false, false}
    self.frozen = {false, false, false}
    self.rotation = {math.pi/4, math.pi/4, math.pi/4}
    self.items = {towers = {}}
    self.key = 0
    self:roll()
end

function shop:update(dt)

end

function shop:mousepressed(x, y)
    if #enemies == 0 then
        for i, v in pairs(self.items.towers) do
            if x > world.x/2 + (i-2)*(world.x/6) - 40 and x < world.x/2 + (i-2)*(world.x/6) + 40
            and y > 7*world.y/8 - 40 and y < 7*world.y/8 + 40 and not self.bought[i] then
                selected = v
                info.selected = v
                info.h = #names[v].levels[1]*25+30
                info.level = 1
                self.key = i
                play('button')
            end
            local box = {}
            if not self.frozen[i] then
                box = textbox('freeze', world.x/2 + (i-2)*(world.x/6) - 40-10, 7*world.y/8+40, 100)
            else
                box = textbox('unfreeze', world.x/2 + (i-2)*(world.x/6) - 40-10, 7*world.y/8+40, 100)
            end
            box.h = box.h
            if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h and #enemies == 0 then
                self.frozen[i] = not self.frozen[i]
                play('freeze')
            end
        end
        if x > world.x/8-4 and x < world.x/8-4 + 98 and 
        y > 7*world.y/8 - 16-4 and y < 7*world.y/8 - 16-4 +52 then
            play('button')
            self:roll()
        end
    end
end

function shop:buy()
    self.bought[self.key] = true
    money = money - 3
end

function shop:draw(x, y)
    for i, v in pairs(self.items.towers) do
        if x > world.x/2 + (i-2)*(world.x/6) - 40 and x < world.x/2 + (i-2)*(world.x/6) + 40
        and y > 7*world.y/8 - 45 and y < 7*world.y/8 + 40 and #enemies == 0 then
            love.graphics.setColor(0, 0, 0, 0.2)
            love.graphics.rectangle('fill', world.x/2 + (i-2)*(world.x/6) - 40, 7*world.y/8 - 47, 80, 80, 3, 3)
            love.graphics.setColor(1, 1, 1)
        end

        local rot = 0 
        if v == 'monkey' then rot = math.pi end
        love.graphics.draw(sprites[v], world.x/2 + (i-2)*(world.x/6), 7*world.y/8, rot, 2, 2, 16, 16)

        languages.update_font('desc')
        love.graphics.print('T'..names[v].tier, world.x/2 + (i-2)*(world.x/6) - 10, 7*world.y/8 - 45)
        languages.update_font('main')
        if self.bought[i] then
            languages.update_font('bought')
            love.graphics.setColor(0, 0, 0, 0.4)
            love.graphics.rectangle('fill', world.x/2 + (i-2)*(world.x/6) - 40, 7*world.y/8 - 47, 80, 80, 3, 3)
            love.graphics.setColor(1, 1, 1)
            love.graphics.printf('bought', world.x/2 + (i-2)*(world.x/6) - 28, 7*world.y/8 - 35, 80, 'center', self.rotation[i])
        end

        local box = {}
        languages.update_font('freeze')
        if not self.frozen[i] then
            box = textbox('freeze', world.x/2 + (i-2)*(world.x/6) - 40-10, 7*world.y/8+40, 100)
        else
            box = textbox('unfreeze', world.x/2 + (i-2)*(world.x/6) - 40-10, 7*world.y/8+40, 100)
        end
        if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h and #enemies == 0 then
            love.graphics.setColor(0, 0, 0, 0.2)
            love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
            love.graphics.setColor(1, 1, 1)
        end
        if not self.frozen[i] then
            languages.printf('freeze', world.x/2 + (i-2)*(world.x/6) - 40-10, 7*world.y/8+40, 100, 'center')
        else
            languages.printf('unfreeze', world.x/2 + (i-2)*(world.x/6) - 40-10, 7*world.y/8+40, 100, 'center')
        end
    end
    languages.update_font('desc')

    for i, v in pairs(self.items.towers) do
        if x > world.x/2 + (i-2)*(world.x/6) - 40 and x < world.x/2 + (i-2)*(world.x/6) + 40
        and y > 7*world.y/8 - 45 and y < 7*world.y/8 + 40 and #enemies == 0 then
            local b1 = textboxB({'Targets', ': '}, x, y)
            b1.y = b1.y - b1.h
            local b2 = textboxB(names[v].unit, x + b1.w, b1.y)
            local b3 = textbox(names[v].desc, x, b1.y, 180)
            b3.y = b3.y - b3.h
            local b4 = textbox(v, x, b3.y, 180)
            b4.y = b4.y - b4.h
    
            box = merge_boxes({b1, b2, b3, b4})

            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle('fill', box.x-2, box.y-2, box.w+4, box.h+4, 3, 3)
            
            love.graphics.setColor(30/255,144/255,255/255)
            love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
            
            love.graphics.setColor(1, 1, 1)
            
            
            languages.printf(v, x, b4.y, 180, 'center')
            languages.printf(names[v].desc, x, b3.y, 180, 'center')
            languages.print({'Targets', ': '}, x, b2.y)
            languages.print(names[v].unit, b1.x + b1.w, b2.y)
        end
    end

    love.graphics.setColor(0, 0, 0, 0.2)
    languages.update_font('main')
    
    local box1 = textbox({'roll', '    '}, centre.x-150, 50, 300)
    local box2 = textbox({'tower', '   '}, centre.x-150, 70, 300)
    local box = merge_boxes({box1, box2})
    box.w = box.w*2
    love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)

    local reroll_box = textboxB('reroll', world.x/8, 7*world.y/8 - 16)
    local space_box = textboxB('(space)', world.x/8+12, 7*world.y/8+12)
    box = merge_boxes({reroll_box, space_box})
    if x > box.x and x < box.x + box.w -30 and y > box.y and y < box.y+box.h-10 and #enemies == 0 then
        love.graphics.rectangle('fill', box.x, box.y, box.w-30, box.h-10, 3, 3)
    end

    languages.update_font('main')
    love.graphics.setColor(1, 1, 1)
    languages.print('reroll', world.x/8, 7*world.y/8 - 16)
    languages.update_font('desc')
    languages.print('(space)', world.x/8+12, 7*world.y/8+12)

    
    languages.printf({'roll', '    '}, centre.x-150, 50, 300, 'center')
    local width = love.graphics.getFont():getWidth(translations['roll'][config['language']])
    love.graphics.draw(sprites.coin, centre.x + width/2 + 34, 48)

    languages.printf({'tower', '   '}, centre.x-150, 70, 300, 'center')
    local width = love.graphics.getFont():getWidth(translations['tower'][config['language']])
    love.graphics.draw(sprites.coin, centre.x + width/2 + 20, 68)
    love.graphics.draw(sprites.coin, centre.x + width/2 + 34, 68)
    love.graphics.draw(sprites.coin, centre.x + width/2 + 48, 68)


    
    if #enemies ~= 0 then
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle('fill', world.x/8-10, 7*world.y/8 - 50, 3*world.x/4+40, 120, 3, 3)
        love.graphics.setColor(1, 1, 1)
        languages.update_font('main')
        languages.printf('locked during battle', world.x/8-10, 7*world.y/8,  3*world.x/4+40, 'center')
    end
end

function shop:roll()
    selected = ''
    self.tier = tier
    self.selection = {}
    for k, v in pairs(names) do
        if v.tier <= self.tier then
            table.insert(self.selection, k)
        end
    end
    if money >= 1 then
        for i=1, 3 do
            if not self.frozen[i] or self.bought[i] then
                local adding = self.selection[math.random(1, #self.selection)]
                for i=1, 2 do
                    if adding ~= 'monkey' then break else adding = self.selection[math.random(1, #self.selection)] end
                end
                self.items.towers[i] = adding
                if self.frozen[i] then self.frozen[i] = false end
            end
        end
        money = money - 1
        self.bought = {false, false, false}
    end
end

return shop