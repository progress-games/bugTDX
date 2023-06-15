local game = {}

function game.load()
    sprites = {
        grass = Image('grass-1'),
        path = Image('path-1'),
        crossbow = Image('crossbow-1'),
        arrow = Image('arrow-1'),
        cannon = Image('cannon-1'),
        ball = Image('ball-1'),
        fistbullet = Image('fistbullet'),
        fist = Image('fist'),
        burner = Image('burner-1'),
        flame = Image('flame-1'),
        flameoutline = Image('flameoutline-1'),
        coin = Image('coin'),
        pot = Image('pot-1'),
        shotgun = Image('shotgun-1'),
        pellet = Image('pellet-1'),
        oil = Image('oil'),
        ant = Image('ant'),
        bee = Image('bee'),
        caterpillar = Image('caterpillar'),
        butterfly = Image('butterfly'),
        snail = Image('snail'),
        hose = Image('hose-1'),
        water = Image('water'),
        speedgun = Image('speedgun-1'),
        laser = Image('laser'),
        portal = Image('portal-1'),
        ritual = Image('ritual-1'),
        lmg = Image('lmg'),
        moneybag = Image('moneybag-1'),
        plus = Image('plus'),
        heart = Image('heart'),
        fan = Image('fan'),
        bazooka = Image('bazooka'),
        rocket = Image('rocket'),
        campfire = Image('campfire'),
        magnifier = Image('magnifier'),
        sunray = Image('sunray'),
        ice = Image('ice'),
        freeze = Image('freeze'),
        slow = Image('slow'),
        push = Image('pushback'),
        icebullet = Image('icebullet'),
        fridge = Image('fridge'),
        fridgeopen = Image('fridgeopen'),
        volcano = Image('volcano'),
        wizardtower = Image('wizardtower'),
        lightningball = Image('lightningball'),
        cloud = Image('cloud'),
        waterdrop = Image('waterdrop'),
        cockroach = Image('cockroach'),
        spider = Image('spider'),
        ladybug = Image('ladybug'),
        beetle = Image('beetle'),
        mosquito = Image('mosquito'),
        flamingoil = Image('flamingoil'),
        blackhole = Image('blackhole'),
        weight = Image('weight'),
        weightb = Image('weightb'),
        pirate = Image('pirate'),
        railgun = Image('railgun'),
        railgunb = Image('railgunb'),
        metropolis = Image('metropolis'),
        brick = Image('brick'),
        amp = Image('amp'),
        sniper = Image('sniper'),
        sniperb = Image('sniperb'),
        tricannon = Image('tricannon'),
        xpbooster = Image('xpbooster'),
        rent = Image('rent'),
        shapeshifter = Image('shapeshifter'),
        detonator = Image('detonator'),
        dynamite = Image('dynamite'),
        laserblast = Image('laserblast'),
        laserblaster = Image('laserblaster'),
        nuclear = Image('nuclear'),
        overload = Image('overload'),
        stopwatch = Image('stopwatch'),
        nailgun = Image('nailgun'),
        nail = Image('nail'),
        barrel = Image('barrel'),
        lightning = Image('lightning'),
        stopwatch = Image('stopwatch'),
        monkey = Image('monkey'),
        dart = Image('dart'),
        spikes = Image('spikes'),
        spike = Image('spike'),
        frostedspikes = Image('frostedspikes'),
        frostedspike = Image('frostedspike'),
        pointer = Image('pointer'),
        flamethrower = Image('flamethrower'),
        bone = Image('bone'),
        affliction = Image('affliction'),
        energizer = Image('energizer'),
        elightning = Image('elightning'),
        poison = Image('poison'),
        poisondrop = Image('poisondrop'),
        pesticide = Image('pesticide'),
        fly = Image('fly'),
        mantis = Image('mantis'),
        dragonfly = Image('dragonfly'),
        slug = Image('slug'),
        moth = Image('moth'),
        electrocution = Image('electrocution'),
        stone = Image('stone'),
        confusion = Image('confusion'),
        empowered = Image('empowered')
    }

    --cases {stat, value}, string, {{stat, stat effect}, value}

    for name, _ in pairs(names) do
        local temp = _G[capitalise(name)]({0, 0}, nil, name)
        local level = {{}, {}, {}}
        for i=1, 3 do
            if temp.range and temp.range ~= 0 then table.insert(level[i], {'range', tostring(temp.range/32)}) end
            if temp.dmg and temp.dmg ~= 0 then table.insert(level[i], {'damage', tostring(temp.basedmg or temp.dmg)}) end
            if temp.firerate and temp.firerate ~= 0 then table.insert(level[i], {'firerate', tostring(temp.firerate)}) end
            if temp.effect == 'weaken' then table.insert(level[i], {'extra damage', tostring((temp.stats.mult-1)*100)..'%'}) end
            if temp.stats.ratedur then table.insert(level[i], {'effect duration', tostring(temp.stats.ratedur)}) end
            if temp.stats.dmg and temp.effect ~= 'lightningw' then table.insert(level[i], {{temp.effect, 'damage'}, tostring(temp.stats.dmg)}) end
            if temp.bspd and temp.bspd ~= 0 then table.insert(level[i], {'bullet speed', tostring(temp.bspd/60)}) end
            if temp.effect == 'explode' then table.insert(level[i], {'explosion radius', tostring(temp.stats.radius/32)}) end
            if temp.name == 'xpbooster' then table.insert(level[i], "Doesn't change"); table.insert(level[i], '') end
            if temp.effect == 'lightning' or temp.effect == 'lightningw' then table.insert(level[i], {'max chains', temp.stats.max}) end
            if temp.stats.rate then table.insert(level[i], {{temp.effect, 'rate'}, temp.stats.rate}) end
            if temp.effect == 'speed' then table.insert(level[i], {'damage multiplier', (100*(temp.stats.mult-1))..'%'}) end
            if temp.stats.dur and temp.name ~= 'campfire' then table.insert(level[i], {'pool duration', temp.stats.dur}) end
            if temp.stats.slow then table.insert(level[i], {'slow speed', temp.stats.slow/60}) end
            if temp.name == 'moneybag' then table.insert(level[i], {'money gain', temp.gain.max}) end
            if temp.name == 'lmg' and temp.lvl == 3 then table.insert(level[i], 'can shoot ground units') end
            if temp.effect == 'wet' or temp.effect == 'lightningw' then table.insert(level[i], {'speed increase', temp.stats.speed/60}) end
            if temp.effect == 'push' then table.insert(level[i], {'push strength', temp.stats.push/60}) end
            if temp.effect == 'burn mult' then table.insert(level[i], {'burn multiplier', temp.stats.mult..'x'}) end
            if temp.effect == 'pull' then table.insert(level[i], {'pull strength', temp.stats.strength/60}) end
            if temp.effect == 'afflict' then table.insert(level[i], {'effects multiplier', temp.stats.mult..'x'}) end
            if temp.towermult then table.insert(level[i], {'tower multiplier', temp.towermult}) end
            if temp.name == 'rent' then table.insert(level[i], {'additional spaces', temp.spaces}); table.insert(level[i], {'fee', temp.fee}) end
            if temp.name == 'railgun' then table.insert(level[i], {'firerate cap', temp.minfirerate}) end
            if temp.moneymult then table.insert(level[i], {'money multiplier', temp.moneymult}) end
            if temp.name == 'pirate' then table.insert(level[i], ''); table.insert(level[i], {'damage is calculated as:', ' '}); table.insert(level[i], 'damage + money * multiplier') end
            if temp.name == 'shapeshifter' then table.insert(level[i], {'shapeshifted tower level', i}) end
            if temp.name == 'nailgun' then table.insert(level[i], 'extra damage against enemies'); table.insert(level[i], {'without status effects', ((temp.stats.mult-1)*100)..'%'}) end
            if temp.name == 'overload' then 
                table.insert(level[i], {'firerate increase', ((1-temp.boost.firerate)*100)..'%'})
                table.insert(level[i], {'extra damage', ((temp.boost.dmg-1)*100)..'%'})
                table.insert(level[i], {'max connections', temp.connections}) end
            if temp.name == 'monkey' then table.insert(level[i], "doesn't change") end
            table.insert(level[i], {'Targets', temp.unit})
            if i <= 2 then temp.lvl = temp.lvl + 1 end
            temp:updatedesc()
            table.insert(level[i], '')
        end
        names[name].levels = table.copy(level)
    end

    board = {}
    for i=1, 16 do
        board[i] = {}
        for k=1, 8 do
            board[i][k] = {ground = sprites.grass, sprite = nil, name == 'grass'}
        end
    end

    arrows = {{1000, 2,x=0, y=0, dir = 1}}
    paths = {}
    holding = {}

    paths[1] = newpath('horizontal')

    particles = Particles()

    enemies = {}
    bullets = {}
    towerpos = {}
    max_showing = round(-10*window.scale+25)
    showing = {1, max_showing}
    selected = ''
    money = 11
    wave = 0
    pass = 10

    if addicted_timer and addicted_timer <= 30 then
        steam.userStats.setAchievement('ADDICTED')
        steam.userStats.storeStats()
    end

    text = {
        ['Wave'] = {dur = 2.5, timer = 0, colour = {152,251,152}, pausedur = 1.5,
            x = {from = world.x, to = -1000, pause = centre.x},
            y = {from = world.y/2-40, to = world.y/2-40, pause = world.y/2-40}},
        ['Max Towers'] = {dur = 2.5, timer = 0, colour = {255,99,71}, pausedur = 1.5,
            x = {from = world.x, to = -1000, pause = centre.x},
            y = {from = world.y/2-40, to = world.y/2-40, pause = world.y/2-40}},
        ['New Towers']  = {dur = 2.5, timer = 0, colour = {240,230,140}, pausedur = 1.5,
            x = {from = world.x, to = -1000, pause = centre.x},
            y = {from = world.y/2-40, to = world.y/2-40, pause = world.y/2-40}},
    }

    for effect, v in pairs(effects) do
        text[effect] = {dur = 3.5, timer = 3.5, pausedur = 2, colour = v.colour,
        x = {from = -1000, to = 1000, pause = world.x/6},
        y = {from = world.y/2+30, to = world.y/2+30, pause = world.y/2+30}}
    end

    for t, v in pairs(text) do 
        v.vis = false
        v.splash = false 
    end


    wavetowers = difficulty[config.difficulty+1].towers
    maxtowers = wavetowers[1]

    ended = true

    --[[settings = {
        hpvis = true
    }]]
    remove = false

    info = {
        vis = false,
        selected = 'crossbow',
        x = 200,
        y = centre.y/3,
        lock = {0, 0},
        w = 200,
        h = #names['crossbow'].levels[1]*25+30,
        level = 1
    }

    lightning.load()
    settings.load()

    shop = Shop(1)

    audio.music.menu:stop()
    audio.music.building:play()

    tutorial = {}
    tutorial.welcome = false
    tutorial.money = false
    tutorial.health = false
    tutorial.price = false
    tutorial.selected = false
    tutorial.read = false
    tutorial.bought = false
    tutorial.sell = false
    tutorial.roll = false
    tutorial.merge = false
    tutorial.wave = false
    tutorial.ff = false
    
    if config['tutorial'] then
        for k, v in pairs(tutorial) do
            tutorial[k] = true
        end
    end

    state = 'game'
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

function newpath(orientation)
    local function sell(x, y) 
        if board[x][y].obj then
            table.insert(holding, board[x][y])
            board[px][py] = {ground = sprites.path, name = 'path', sprite = nil, stand = false}
        end
        board[x][y].ground, board[x][y].name, board[x][y].obj = sprites.path, 'path', false
    end

    if orientation == 'horizontal' then
        local path = {}
        local sx, sy = 1, math.random(2, 7)
        table.insert(arrows, {sx, sy})
        while true do
            sell(sx, sy)
            table.insert(path, {sx, sy})
            if sx % 3 == 0 and sx ~= 16 then
                local m = ({-1, 1})[math.random(1, 2)]
                while sy + m > 7 or sy + m < 2 do
                    m = ({-1, 1})[math.random(1, 2)]
                end
                sy = sy + m
                sell(sx, sy)
                table.insert(path, {sx, sy})
            end
            sx = sx + 1
            if sx > 16 then break end
        end
        return path
    end

    if orientation == 'vertical' then
        local path = {}
        local sx, sy = math.random(2, 15), 1
        table.insert(arrows, {sx, sy})
        while true do
            sell(sx, sy)
            table.insert(path, {sx, sy})
            if sy % 3 == 0 and sy ~= 8 then
                local m = ({-1, 1})[math.random(1, 2)]
                while sx + m > 15 or sx + m < 2 do
                    m = ({-1, 1})[math.random(1, 2)]
                end
                sx = sx + m
                sell(sx, sy)
                table.insert(path, {sx, sy})
            end
            sy = sy + 1
            if sy > 8 then break end
        end
        return path
    end
end


function swarmcheck()
    if effects.swarm.on then return 5
    else return 0 end
end

function newwave()
    --wave = 20
    if math.random() < 0.2 and config.difficulty > 0 then
        local eff = difficulty[config.difficulty+1].effects[math.random(1, #difficulty[config.difficulty+1].effects)]
        effects[eff].on = true
    end

    if effects.path.on then 
        local orientation = ({'vertical', 'horizontal'})[math.random(1, 2)]
        table.insert(paths, newpath(orientation))
    end
    wave = wave + 1
    local already_sent = {}
    for i=1, #paths do
        already_sent[i] = {0, 0}
    end
    for _, v in pairs(waves[wave]) do
        local path_choice = math.random(1, #paths)
        already_sent[path_choice][2] = 0
        for i=1, difficulty_mod(v[2] + swarmcheck()) do
            path_choice = math.random(1, #paths)
            local path = paths[path_choice]
            local x, y = 0, 0

            if path[1][1] == 1 then x = centre.x - 8*32 - i*16 - already_sent[path_choice][1]*16; y = centre.y - 4*32 + (path[1][2]-1)*32
            elseif path[1][2] == 1 then x = centre.x - 8*32 + (path[1][1]-1)*32; y = centre.y - 4*32 - i*16 - already_sent[path_choice][1]*16 end
            
            already_sent[path_choice][2] = already_sent[path_choice][2] + 1

            local elite_chance = difficulty[config.difficulty+1].elitespawn

            if math.random() <= elite_chance or v[1] == 'beetle' then
                already_sent[path_choice][1] = already_sent[path_choice][1] + 2
                if effects.wings.on then
                    local enemy = Elite(path, x, y, v[1])
                    enemy.unit = 'fly'
                    table.insert(enemies, enemy)
                else
                    table.insert(enemies, Elite(path, x, y, v[1]))
                end
            else
                if effects.wings.on then
                    local enemy = Enemy(path, x, y, v[1])
                    enemy.unit = 'fly'
                    table.insert(enemies, enemy)
                else
                    table.insert(enemies, Enemy(path, x, y, v[1]))
                end
            end
        end
        already_sent[path_choice][1] = already_sent[path_choice][1] + 3*already_sent[path_choice][2]/4
    end

    for i, v in pairs(towerpos) do
        if board[v[1]][v[2]].name == 'pirate' or board[v[1]][v[2]].name == 'shapeshifter' or
        board[v[1]][v[2]].name == 'overload' then 
            board[v[1]][v[2]]:endbuy() 
        end
    end

    money = 0
    text['Wave'].vis = true

    for k, _ in pairs(effects) do
        if effects[k].on then 
            if effects[k].effect ~= nil then
                for i, v in pairs(effects[k].effect) do
                    for _, e in pairs(enemies) do
                        e:takedmg(0, v, effects[k].stats[i])
                    end
                end
            end
            text[k].vis = true 
            effects[k].on = false
        end
    end
end

function difficulty_mod(amount)
    return math.floor(difficulty[config.difficulty+1].number*amount)
end

function game.update(dt)
    if money >= 20 then
        steam.userStats.setAchievement('RICH')
        steam.userStats.storeStats()
    end
    if paused then 
        state = 'settings'
        paused = false
    else
        audio.music.menu:stop()
        if #enemies == 0 then
            if not audio.music.building:isPlaying() then
                audio.music.wave:stop()
                audio.music.building:play()
                audio.music.building:seek(music_starting.base[math.random(1, 5)], 'seconds')
            end
        else
            if not audio.music.wave:isPlaying() then
                audio.music.building:stop()
                audio.music.wave:play()
                audio.music.wave:seek(music_starting.base[math.random(1, 3)], 'seconds')
            end
        end
    end
    particles:update(dt)
    if fast then dt = dt * 1.5 end
    shop:update(dt)
    lightning.update(dt)

    if #enemies == 0 then
        arrows[1].x = arrows[1].x + arrows[1].dir*todt(dt)*0.6
        if arrows[1].x > 10 then arrows[1].dir = -1
        elseif arrows[1].x < -10 then arrows[1].dir = 1 end
    end
        

    for k, v in pairs(text) do
        if v.vis then
            local t = k
            if t == 'Wave' then t = {t, wave} end

            local x = zoom(v.timer, v.x.from, v.x.pause, v.pausedur, v.x.to, v.dur)
            local y = zoom(v.timer, v.y.from, v.y.pause, v.pausedur, v.y.to, v.dur)
            languages.update_font('wave')
            local f = love.graphics.getFont()
            local w, h = 0, 0
            
            if type(t) == 'table' then
                w = f:getWidth(t[1]) + f:getWidth(t[2]) + f:getWidth(' ')
                h = math.max(f:getHeight(t[1]), f:getHeight(t[2]))
            else
                w, h = f:getWidth(t), f:getHeight(t)
            end
            x = x - w/2

            local box = {x = x, y = y, w = w, h = h}

            v.timer = v.timer + dt

            if v.timer > v.dur/2-v.pausedur/2 and not v.splash then
                for i=1, 50 do
                    local colour = {randrgb(unpack(v.colour))}
                    particles:newrectangle(box, randfloat(5, 10), randfloat(0.5, 2), false, colour, 40)
                end
                v.splash = true
            elseif v.timer > v.dur/2+v.pausedur/2 or v.timer < v.dur/2-v.pausedur/2 then
                local dir = math.atan2(y-v.y.pause, x-v.x.pause) + math.pi
                if v.timer > v.dur/2+v.pausedur/2 then
                    dir = math.atan2(y-v.y.to, x-v.x.to) + math.pi
                end
                local colour = {randrgb(unpack(v.colour))}
                particles:newparticle(x+w, math.random(y, y + h), randfloat(5, 10), 
                randfloat(0.5, 2), dir, false, colour, 40)
            end
            if v.timer >= v.dur then
                v.timer = 0
                v.vis = false
                v.splash = false
            end
        else
            v.timer = 0
            v.vis = false
        end
    end

    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale
    mouse.x, mouse.y = x, y

    if love.mouse.isDown(1) then
        if x > info.x and x < info.x + info.w and y > info.y and y < info.y + info.h then
            info.x = info.x + (mouse.x-info.lock[1])
            info.y = info.y + (mouse.y-info.lock[2])
            info.lock = {mouse.x, mouse.y}
        end
    end

    for k, v in pairs(clouds) do
        for _, c in pairs(v) do
            c[1] = c[1] + c[4]*dt
            if c[1] > world.x + 100 then
                clouds[k] = newcloud()
            end
        end
    end

    if keydown('return') and #enemies == 0 then
        newwave()
    end

    for i=#bullets, 1, -1 do
        local k, v = i, bullets[i]
        local d = v:update(dt)
        if d then table.remove(bullets, k)
        elseif v.player then
            for i, e in pairs(enemies) do
                --[[rectangle = {
                    {x = v.x - 8*v.scale*e.scale*math.cos(v.dir), y = v.y - 8*v.scale*e.scale*math.sin(v.dir)},
                    {x = v.x - 8*v.scale*e.scale*math.cos(v.dir), y = v.y + 8*v.scale*e.scale*math.sin(v.dir)}
                }]]
                if math.sqrt((v.x-e.x)^2+(v.y-e.y)^2) < 8*v.scale*e.scale then
                    if e.unit == v.unit or v.unit == 'ground/air' then
                        if v.effect == 'lightningw' then
                            e:takedmg(v.dmg, 'wet', table.copy(v.stats))
                        else
                            e:takedmg(v.dmg, v.effect, table.copy(v.stats))
                        end
                        if v.effect == 'explode' then
                            play('explosion')
                            for _=1, 5 + v.stats.radius do
                                local g = randfloat(0, 0.2)
                                particles:newparticle(v.x + math.random(-v.stats.radius/2, v.stats.radius/2),
                                v.y + math.random(-v.stats.radius/2, v.stats.radius/2), randfloat(15, 25), 
                                randfloat(0.1, 0.5), randfloat(0, 2*math.pi), false, {randfloat(0.7, 1)+g, g, 0}, 10)
                            end
                            for p, m in pairs(enemies) do
                                if math.sqrt((e.x-m.x)^2+(e.y-m.y)^2) <= v.stats.radius and i ~= p then
                                    m:takedmg(v.stats.dmg)
                                end
                            end
                        end
                        if v.effect == 'lightning' or v.effect == 'lightningw' then
                            lightning.newchain(i, 150, v.stats.max-1, table.copy(v.stats))
                        end
                        if v.effect ~= 'oil' and v.effect ~= 'lava' and v.effect ~= 'teleport' and v.effect ~= 'poison' then
                            table.remove(bullets, k)
                        end
                    end
                end
            end
        end
    end

    for i=#enemies, 1, -1 do
        local m = enemies[i]:update(dt)
        if m then
            for _=1, 50 do
                local r = randfloat(0.3, 0.7)
                particles:newparticle(enemies[i].x + math.random(-3, 3),
                enemies[i].y + math.random(-3, 3), randfloat(3, 6), 
                randfloat(0.8, 2), randfloat(0, 2*math.pi), false, {r, 0, 0}, 20)
            end
            if enemies[i].elite then money = money + 1 end
            table.remove(enemies, i) 
            lightning.adjust(i)
            if #enemies == 0 then endwave() else ended = false end
        end
    end

    for i, v in pairs(towerpos) do
        if not board[v[1]][v[2]].sprite then table.remove(towerpos, i)
        else
            local t = board[v[1]][v[2]]
            local b = t:update(dt, enemies)
            if b == 'shoot' then table.insert(bullets, t:shoot()) end
        end
    end

    if pass <= 0 then state = 'endgame' end
    if wave >= 20 and #enemies == 0 then state = 'endgame' end

    if not pause and config['camera'] then
        camera.x = window.x/2 + (mouse.x-centre.x)/12
        camera.y = window.y/2 + (mouse.y-centre.y)/12
    end

    return state
end

function endwave()
    money = money + 10
    shop:roll()
    money = money + 1
    ended = true
    for _, v in pairs(towertier) do 
        if wave == v then
            if wave ~= 16 or config.difficulty > 0 then
                text['New Towers'].vis = true
            end
            if tier + 1 < 6 then
                tier = tier + 1
            end
            pass = pass + 3
        end
    end
    maxtowers = wavetowers[tier]
    for _, v in pairs(towerpos) do
        local t = board[v[1]][v[2]]
        if t.name == 'rent' then money = money - t.fee; maxtowers = maxtowers + t.spaces end
        if t.name == 'overload' then t:endwave() end
    end
end

function game.draw()
    camera:attach()
    for _, v in pairs(clouds) do
        for _, c in pairs(v) do
            love.graphics.setColor(c[5], c[5], c[5])
            love.graphics.circle('fill', c[1], c[2], c[3])
        end
    end

    love.graphics.setColor(143/255, 86/255, 59/255)
    love.graphics.rectangle('fill', centre.x-32*8-5, centre.y-32*4-5, 16*32+10, 8*32+10)

    x, y = love.mouse.getPosition()
    x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale

    love.graphics.setColor(1, 1, 1)

    love.graphics.setColor(0, 0, 0, 0.2)
    love.graphics.rectangle('fill', 40, 40, #tostring(math.max(money, pass))*20+40, 75, 3, 3)
    languages.update_font('main')
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(sprites.coin, 42, 48, 0, 1.4, 1.4)
    love.graphics.print(money, 72, 48)
    love.graphics.draw(sprites.heart, 42, 86, 0, 0.8, 0.8)
    love.graphics.print(pass, 72, 86)

    languages.update_font('main')
    local box = textboxB('sell tower', 6*world.x/8, 7*world.y/8-16)
    if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h and #enemies == 0 then
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)
        love.graphics.setColor(1, 1, 1)
    end
    languages.print('sell tower', 6*world.x/8, 7*world.y/8 - 16)

    languages.update_font('main')
    
    if #enemies == 0 then
        local box = merge_boxes({textboxB('next wave', world.x-200, 38), textboxB('(enter)', world.x-200, 38)})
        box.h = box.h*2
        if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h then
            love.graphics.setColor(0, 0, 0, 0.2)
            love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)

            for i, v in pairs(waves[wave + 1]) do
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(sprites[v[1]], world.x-205+30*(i-1), 80, 0, 0.8, 0.8)
            end
        end

        love.graphics.setColor(1, 1, 1)
        languages.print('next wave', world.x-200, 38)
        languages.update_font('desc')
        languages.print('(enter)', world.x-150, 64)
    else
        love.graphics.setColor(0, 0, 0, 0.2)
        local box = textboxB({'Wave ', wave}, world.x-200, 38)
        love.graphics.rectangle('fill', box.x, box.y, box.w, box.h, 3, 3)

        love.graphics.setColor(1, 1, 1)
        languages.print({'Wave ', wave}, world.x-200, 38)
    end

    for i=1, #board do
        for k=1, #board[i] do
            love.graphics.draw(board[i][k].ground, centre.x+32*(i-9), centre.y+32*(k-5))
        end
    end
    
    for _, v in pairs(bullets) do
        v:draw()
    end
    particles:draw(true)

    for i=1, #board do
        for k=1, #board[i] do
            if board[i][k].obj then
                board[i][k]:draw(x, y)
            end
        end
    end
    
    for i, v in pairs(enemies) do
        v:draw(x, y)
    end

    
    languages.update_font('desc')
    if info.vis then 
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', info.x, info.y, info.w, info.h, 3, 3)
        love.graphics.rectangle('fill', info.x + (info.level-1)*info.w/3, info.y+info.h-30, info.w/3, 30, 3, 3)
        if x > info.x + 2*info.w/3 and x < info.x + info.w and y > info.y and y < info.y + 20 then
            love.graphics.setColor(0, 0, 0, 0.2)
            love.graphics.rectangle('fill', info.x+2*info.w/3, info.y, info.w/3, 20, 3, 3)
        end
        for i=1, 3 do 
            if x > info.x + (i-1)*info.w/3 and x < info.x + (i-1)*info.w/3 + info.w/3 and y > info.y+info.h-30 and y < info.y+info.h then
                love.graphics.rectangle('fill', info.x + (i-1)*info.w/3, info.y+info.h-30, info.w/3, 30, 3, 3)
            end
        end
        love.graphics.setColor(1, 1, 1)
        languages.printf(info.selected, info.x, info.y+2, info.w, 'center')

        local height = love.graphics.getFont():getHeight()
        for shift, desc in pairs(names[info.selected].levels[info.level]) do
            if type(desc) == 'string' then
                languages.print(desc, info.x+5, info.y + 25 + height*(shift-1))
            else
                if type(desc[1]) == 'string' then
                    languages.print({desc[1], desc[2]}, info.x+5, info.y + 25 + height*(shift-1), ':')
                else
                    languages.print(desc[1][1], info.x+5, info.y + 25 + height*(shift-1))
                    local f = love.graphics.getFont()
                    local w = f:getWidth(translations[desc[1][1]][config['language']]..' ')
                    languages.print({desc[1][2], desc[2]}, info.x+5+w, info.y + 25 + height*(shift-1), ':')
                end
            end
        end

        --languages.print(table.concat(names[info.selected].levels[info.level], '\n'), info.x+5, info.y + 25)
        love.graphics.printf('I', info.x, info.y+info.h-20, info.w/3, 'center')
        love.graphics.printf('II', info.x+info.w/3, info.y+info.h-20, info.w/3, 'center')
        love.graphics.printf('III', info.x+2*info.w/3, info.y+info.h-20, info.w/3, 'center')
        love.graphics.setFont(font.english.main)
        love.graphics.printf('-', info.x+2*info.w/3, info.y-3, info.w/3, 'center')
        languages.update_font('main')
    else
        if x > info.x +2*info.w/3 and x < info.x + info.w and y > info.y and y < info.y + 20 then
            love.graphics.setColor(0, 0, 0, 0.2)
            love.graphics.rectangle('fill', info.x+2*info.w/3, info.y, info.w/3, 20, 3, 3)
        end
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', info.x, info.y, info.w, 20, 3, 3)
        love.graphics.setColor(1, 1, 1)
        languages.printf(info.selected, info.x, info.y+2, info.w, 'center')
        love.graphics.setFont(font.english.main)
        love.graphics.printf('+', info.x+2*info.w/3, info.y-3, info.w/3, 'center')
        languages.update_font('main')
    end
    if rectangle then
        love.graphics.line(rectangle[1].x, rectangle[1].y, rectangle[2].x, rectangle[2].y)
    end

    lightning.draw()

    if #enemies == 0 then
        for _, v in pairs(arrows) do
            local ax, ay = cordstoxy(v[1], v[2])
            if v[1] == 1 then 
                love.graphics.draw(sprites.pointer, ax-50+arrows[1].x, ay)
            elseif v[2] == 1 then
                love.graphics.draw(sprites.pointer, ax+32, ay-50+arrows[1].x, math.pi/2)
            end
        end
    end

    languages.update_font('desc')
    if #holding ~= 0 then
        local rect = {x = 10, y = 200-32, w = 95, h = 42*(#holding+1)+10}
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', rect.x, rect.y, rect.w, rect.h, 3, 3)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf('holding', rect.x, rect.y+5, rect.w, 'center')
        for i, v in pairs(holding) do
            if x > rect.x+rect.w/2-16 and x < rect.x+rect.w/2+16 and y > rect.y+42*(i) and y < rect.y+42*(i+1) and #enemies == 0 then
                love.graphics.setColor(0, 0, 0, 0.2)
                love.graphics.rectangle('fill', rect.x+rect.w/2-16-5, rect.y+42*(i)-5, 32+10, 32+10, 3, 3)
                love.graphics.setColor(1, 1, 1)
            end
            love.graphics.draw(v.sprite, rect.x+rect.w/2-16, rect.y+42*(i))
        end

        if #enemies ~= 0 then
            love.graphics.setColor(0, 0, 0, 0.4)
            love.graphics.rectangle('fill', rect.x, rect.y, rect.w, rect.h, 3, 3)
            love.graphics.setColor(1, 1, 1)
            languages.update_font('bought')
            languages.printf('locked during battle', rect.x+15, rect.y+rect.h/4, rect.w, 'center')
        end
    end

    if #towerpos > max_showing then
        local tx, ty, tw, th =  7*world.x/8-5, 200-32-5, 80+15, 32*10+10
        local p1 = {x = tx-40, y = ty+th/2-20}
        local p2 = {x = tx-8, y= ty+th/2+20}

        love.graphics.setColor(0, 0, 0, 0.2)
        if x > p1.x-2 and x < p1.x -2 + 36 and y > p1.y-34 and y < p1.y -34 + 36 then
            love.graphics.rectangle('fill', p1.x-2, p1.y-34, 36, 36, 3, 3)
        elseif x > p2.x-24 and x < p2.x -2 and y > p2.y-2 and y < p2.y -2+36 then
            love.graphics.rectangle('fill', p2.x-34, p2.y-2, 36, 36, 3, 3)
        end
        
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(sprites.pointer, p1.x, p1.y, -math.pi/2)
        love.graphics.draw(sprites.pointer, p2.x, p2.y, math.pi/2)
    end

    shop:draw(x, y)

    x, y = x - (centre.x - 8*32), y - (centre.y - 4*32)
    px, py = round(x/32-0.5)+1, round(y/32-0.5)+1
    x, y = round(x/32-0.5)*32 + (centre.x - 8*32), round(y/32-0.5)*32 + (centre.y - 4*32)

    if x > (centre.x - 9*32) and x < (centre.x + 8*32) and y > (centre.y - 5*32) and y < (centre.y + 4*32) then
        if selected == '' then
            love.graphics.rectangle('line', x, y, 32, 32)
        else
            if board[px][py].name == selected then
                love.graphics.draw(sprites.plus, x, y)
            else
                love.graphics.setColor(1, 1, 1, 0.3)
                local temp = _G[capitalise(selected)]({0, 0}, ground, selected)
                love.graphics.draw(sprites[selected], x, y)
                love.graphics.setColor(1, 1, 1)
                love.graphics.circle('line', x+16, y+16, temp.range)
            end
        end
    end

    love.graphics.setColor(0, 0, 0, 0.2)
    love.graphics.rectangle('fill', 7*world.x/8-5, 200-32-5, 80+15, 32*(math.min(10, #towerpos)+1)+10, 3, 3)

    love.graphics.setColor(1, 1, 1)
    languages.update_font('desc')
    if maxtowers == nil then print(wave, #towerpos, tier); print(wavetowers[tier]) end
    languages.print({#towerpos..'/'..maxtowers, 'towers'}, 7*world.x/8, 200-30)

    local todelete = {}
    if #towerpos <= 10 then
        for i, v in pairs(towerpos) do
            if board[v[1]][v[2]].sprite then
                love.graphics.draw(board[v[1]][v[2]].sprite, 7*world.x/8, 200 + 32*(i-1))
                love.graphics.print(({'I', 'II', 'III'})[board[v[1]][v[2]].lvl], 7*world.x/8+40, 200+32*(i-1))

                if board[v[1]][v[2]].lvl == 3 then
                    languages.print({'max', 'xp'}, 7*world.x/8+40, 200+32*(i-1)+15)
                elseif board[v[1]][v[2]].lvl == 2 then
                    love.graphics.print(board[v[1]][v[2]].xp..'/5 xp', 7*world.x/8+40, 200+32*(i-1)+15)
                elseif board[v[1]][v[2]].lvl == 1 then
                    love.graphics.print(board[v[1]][v[2]].xp..'/3 xp', 7*world.x/8+40, 200+32*(i-1)+15)
                end
            else table.insert(todelete, i) end
        end
    else
        local i = 1
        for shift=showing[1], showing[2] do
            local v = towerpos[shift]
            if board[v[1]][v[2]].sprite then
                love.graphics.draw(board[v[1]][v[2]].sprite, 7*world.x/8, 200 + 32*(i-1))
                love.graphics.print(({'I', 'II', 'III'})[board[v[1]][v[2]].lvl], 7*world.x/8+40, 200+32*(i-1))

                if board[v[1]][v[2]].lvl == 3 then
                    languages.print({'max', 'xp'}, 7*world.x/8+40, 200+32*(i-1)+15)
                elseif board[v[1]][v[2]].lvl == 2 then
                    love.graphics.print(board[v[1]][v[2]].xp..'/5 xp', 7*world.x/8+40, 200+32*(i-1)+15)
                elseif board[v[1]][v[2]].lvl == 1 then
                    love.graphics.print(board[v[1]][v[2]].xp..'/3 xp', 7*world.x/8+40, 200+32*(i-1)+15)
                end
            else table.insert(todelete, i) end
            i = i + 1
        end
    end

    for i=1, #todelete do
        table.remove(towerpos, todelete[i])
    end

    for k, v in pairs(text) do
        local t = k
        if t == 'Wave' then t = {t, wave} end
        if v.vis then
            local x = zoom(v.timer, v.x.from, v.x.pause, v.pausedur, v.x.to, v.dur)
            local y = zoom(v.timer, v.y.from, v.y.pause, v.pausedur, v.y.to, v.dur)
            languages.update_font('wave')
            local f = love.graphics.getFont()
            local w = 0
            
            if type(t) == 'table' then
                w = f:getWidth(t[1]) + f:getWidth(t[2])
            else
                w = f:getWidth(t)
            end
            x = x - w/2
            
            love.graphics.setColor(0, 0, 0.3)
            languages.outline(t, x, y, 2)
        end
    end

    if paused then  
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', -1000, -1000, world.x+1000, world.y+1000)
        love.graphics.setColor(0,181/255,226/255)
        love.graphics.rectangle('fill', -1000, -1000, world.x+1000, world.y+1000)
        settings.draw()
    end

    languages.update_font('desc')
    r2 = textbox('left click to advance the tutorial!', 0, world.y/2+90, world.x)
    r3 = textbox('left click to advance the tutorial!', 0, world.y/2, world.x)

    if not tutorial.welcome then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('huge')
        r1 = textbox('Welcome to bugTDX', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r2.x)
        local y = math.min(r1.y, r2.y)
        local w = math.max(r1.x + r1.w, r2.x + r2.w) - x
        local h = math.max(r1.y + r1.h, r2.y + r2.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)
        languages.update_font('huge')
        languages.printf('Welcome to bugTDX', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to advance the tutorial!', centre.x-8*32, world.y/2+90, 16*32, 'center')
    elseif not tutorial.money then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('main')
        r1 = textbox('Here is your money. You get 10 gold each round', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r3.x)
        local y = math.min(r1.y, r3.y)
        local w = math.max(r1.x + r1.w, r3.x + r3.w) - x
        local h = math.max(r1.y + r1.h, r3.y + r3.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)

        love.graphics.draw(sprites.pointer, #tostring(math.max(money, pass))*20+120, 75, math.pi)

        languages.printf('Here is your money. You get 10 gold each round', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to advance the tutorial!', 0, world.y/2, world.x, 'center')
    elseif not tutorial.health then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('main')
        r1 = textbox('Here is your health. It increases over time but if it reaches 0 you lose', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r3.x)
        local y = math.min(r1.y, r3.y)
        local w = math.max(r1.x + r1.w, r3.x + r3.w) - x
        local h = math.max(r1.y + r1.h, r3.y + r3.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)

        love.graphics.draw(sprites.pointer, #tostring(math.max(money, pass))*20+120, 115, math.pi)

        languages.printf('Here is your health. It increases over time but if it reaches 0 you lose', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to advance the tutorial!', 0, world.y/2, world.x, 'center')
    elseif not tutorial.price then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('main')
        r1 = textbox('Here is how much things cost. 3 for a tower and 1 for a reroll', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r3.x)
        local y = math.min(r1.y, r3.y)
        local w = math.max(r1.x + r1.w, r3.x + r3.w) - x
        local h = math.max(r1.y + r1.h, r3.y + r3.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)

        love.graphics.draw(sprites.pointer, centre.x-68+110, 115, -math.pi/2)

        languages.printf('Here is how much things cost. 3 for a tower and 1 for a reroll', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to advance the tutorial!', 0, world.y/2, world.x, 'center')
    elseif not tutorial.selected then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('main')
        r1 = textbox('Select a tower to place from the shop', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r3.x)
        local y = math.min(r1.y, r3.y)
        local w = math.max(r1.x + r1.w, r3.x + r3.w) - x
        local h = math.max(r1.y + r1.h, r3.y + r3.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)

        for i=1, 3 do
            love.graphics.draw(sprites.pointer, world.x/2 + (i-2)*(world.x/6)+10, 7*world.y/8 - 90, math.pi/2)
        end

        languages.printf('Select a tower to place down from the shop', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to advance the tutorial!', 0, world.y/2, world.x, 'center')
    elseif not tutorial.read then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('main')
        r1 = textbox('Click this to have a look at the info for any selected tower for any level. You can drag it around too!', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r2.x)
        local y = math.min(r1.y, r2.y)
        local w = math.max(r1.x + r1.w, r2.x + r2.w) - x
        local h = math.max(r1.y + r1.h, r2.y + r2.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)

        love.graphics.draw(sprites.pointer, centre.x-68+135, 115, math.pi)

        languages.printf('Click this to have a look at the info for any selected tower for any level. You can drag it around too!', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to advance the tutorial!', 0, world.y/2+90, world.x, 'center')
    elseif not tutorial.bought then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('main')
        r1 = textbox('Place the tower down somewhere to buy it!', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r3.x)
        local y = math.min(r1.y, r3.y)
        local w = math.max(r1.x + r1.w, r3.x + r3.w) - x
        local h = math.max(r1.y + r1.h, r3.y + r3.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)

        languages.printf('Place the tower down somewhere to buy it!', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to advance the tutorial!', 0, world.y/2, world.x, 'center')
    elseif not tutorial.roll then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('main')
        r1 = textbox('To sell a tower press the sell tower button then select the tower you want to sell', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r3.x)
        local y = math.min(r1.y, r3.y)
        local w = math.max(r1.x + r1.w, r3.x + r3.w) - x
        local h = math.max(r1.y + r1.h, r3.y + r3.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)

        love.graphics.draw(sprites.pointer, 6*world.x/8+80, 7*world.y/8 - 60, math.pi/2)

        languages.printf('To sell a tower press the sell tower button then select the tower you want to sell', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to advance the tutorial!', 0, world.y/2, world.x, 'center')
    elseif not tutorial.roll then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('main')
        r1 = textbox('Press roll to roll the shop!', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r3.x)
        local y = math.min(r1.y, r3.y)
        local w = math.max(r1.x + r1.w, r3.x + r3.w) - x
        local h = math.max(r1.y + r1.h, r3.y + r3.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)

        love.graphics.draw(sprites.pointer, world.x/8-4+60, 7*world.y/8 - 50, math.pi/2)

        languages.printf('Press roll to roll the shop!', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to advance the tutorial!', 0, world.y/2, world.x, 'center')
    elseif not tutorial.merge then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('main')
        r1 = textbox('Place towers of the same type ontop each other to level them up! You can see the levels of your towers here', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r2.x)
        local y = math.min(r1.y, r2.y)
        local w = math.max(r1.x + r1.w, r2.x + r2.w) - x
        local h = math.max(r1.y + r1.h, r2.y + r2.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)

        love.graphics.draw(sprites.pointer, 7*world.x/8+60, 120, math.pi/2)

        languages.printf('Place towers of the same type ontop each other to level them up! You can see the levels of your towers here', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to advance the tutorial!', 0, world.y/2+90, world.x, 'center')
    elseif not tutorial.wave then
        love.graphics.setColor(0, 0, 0, 0.2)

        languages.update_font('main')
        r1 = textbox('Press the f key to watch the game at 1.5x speed!', centre.x-8*32, world.y/2-100, 16*32)

        local x = math.min(r1.x, r3.x)
        local y = math.min(r1.y, r3.y)
        local w = math.max(r1.x + r1.w, r3.x + r3.w) - x
        local h = math.max(r1.y + r1.h, r3.y + r3.h) - y

        love.graphics.rectangle('fill', x, y, w, h, 6, 6)

        love.graphics.setColor(1, 1, 1)

        languages.printf('Press the f key to watch the game at 1.5x speed!', centre.x-8*32, world.y/2-100, 16*32, 'center')

        languages.update_font('desc')
        languages.printf('left click to finish the tutorial!', 0, world.y/2, world.x, 'center')
    end
    camera:detach()
    camera:draw()
end

function cordstoxy(x, y)
    return (x-1)*32+centre.x-8*32, (y-1)*32+centre.y-4*32
end

function updateplaces(x, y)
    local cmax = wavetowers[math.floor(wave/5)+1]
    local pmax = cmax
    for _, v in pairs(towerpos) do
        local t = board[v[1]][v[2]]
        if t.name == 'rent' then 
            pmax = pmax + t.spaces 
        end
    end
    local diff = pmax - cmax - 1
    local todelete = {}
    for i=1, math.min(#towerpos, diff) do
        table.insert(holding, board[towerpos[i][1]][towerpos[i][2]])
        table.remove(towerpos, i)
    end
end

function game.mousepressed(_, _, button)
    if not paused and not tutorial.no_click then
        if button == 2 then selected = '' end

        x, y = love.mouse.getPosition()
        x, y = (x + (camera.x - camera.w/2)*window.scale)/window.scale, (y + (camera.y - camera.h/2)*window.scale)/window.scale

        if x > centre.x - 8*32 and x < centre.x + 8*32 and y > centre.y - 4*32 and y < centre.y + 4*32 then
            if not tutorial.welcome then tutorial.welcome = true
            elseif not tutorial.money then tutorial.money = true
            elseif not tutorial.health then tutorial.health = true
            elseif not tutorial.price then tutorial.price = true
            elseif not tutorial.selected then tutorial.selected = true
            elseif not tutorial.read then tutorial.read = true
            elseif not tutorial.bought then tutorial.bought = true
            elseif not tutorial.sell then tutorial.sell = true
            elseif not tutorial.roll then tutorial.roll = true
            elseif not tutorial.merge then tutorial.merge = true
            elseif not tutorial.wave then tutorial.wave = true; config['tutorial'] = true end
        end

        info.lock = {x, y}

        languages.update_font('main')
        local box = merge_boxes({textboxB('next wave', world.x-200, 38), textboxB('(enter)', world.x-200, 38)})
        box.h = box.h*2
        if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h and #enemies == 0 then
            newwave()
            play('button')
        end

        local box = textboxB('sell tower', 6*world.x/8, 7*world.y/8-16)
        if x > box.x and x < box.x + box.w and y > box.y and y < box.y + box.h and #enemies == 0 then
            selected = ''
            remove = true
            play('button')
        end

        if #towerpos > max_showing then
            local tx, ty, tw, th =  7*world.x/8-5, 200-32-5, 80+15, 32*10+10
            local p1 = {x = tx-40, y = ty+th/2-20}
            local p2 = {x = tx-8, y= ty+th/2+20}

            if x > p1.x-2 and x < p1.x -2 + 36 and y > p1.y-34 and y < p1.y -34 + 36 and showing[1] > 1 then
                showing = {showing[1]-1, showing[2]-1}
                play('button')
            elseif x > p2.x-24 and x < p2.x -2 and y > p2.y-2 and y < p2.y -2+36 and showing[2] < #towerpos then
                showing = {showing[1]+1, showing[2]+1}
                play('button')
            end
        end

        for i=1, 3 do
            if x > info.x + (i-1)*info.w/3 and x < info.x + (i-1)*info.w/3 + info.w/3 and y > info.y+info.h-30 and y < info.y+info.h then
                info.level = i
                play('button')
            end
        end

        if x > info.x + 2*info.w/3 and x < info.x + info.w and y > info.y and y < info.y + 20 then
            play('button')
            info.vis = not info.vis
        end

        shop:mousepressed(x, y)

        x, y = x - (centre.x - 8*32), y - (centre.y - 4*32)
        px, py = round(x/32-0.5)+1, round(y/32-0.5)+1
        x, y = x + (centre.x - 8*32), y + (centre.y - 4*32)

        if px >= 1 and px <= #board and py >= 1 and py <= #board[1] and selected ~= '' then
            if not board[px][py].sprite and #towerpos < maxtowers and money >= 3 and board[px][py].ground ~= sprites.path
            and not (x > info.x and x < info.x + info.w and y > info.y and y < info.y + info.h and info.vis)
            and not (x > info.x and x < info.x + info.w and y > info.y and y < info.y + 20 and not info.vis) then
                if placingheld then
                    board[px][py] = holding[heldindex]
                    if selected == 'xpbooster' or selected == 'rent' then
                        board[px][py]:placed()
                    end
                    board[px][py]:move({px, py})
                    table.insert(towerpos, {px, py})
                    play('placetower')
                    selected = ''
                    holding[heldindex] = nil
                    placingheld = false
                else
                    board[px][py] = _G[capitalise(selected)]({px, py}, board[px][py].ground, selected)
                    if selected == 'xpbooster' or selected == 'rent' then
                        board[px][py]:placed()
                    end
                    selected = ''
                    table.insert(towerpos, {px, py})
                    play('placetower')
                    shop:buy()
                end
            elseif board[px][py].name == selected and money >= 3 and board[px][py].ground ~= sprites.path 
            and not (x > info.x and x < info.x + info.w and y > info.y and y < info.y + info.h and info.vis) 
            and not (x > info.x and x < info.x + info.w and y > info.y and y < info.y + 20 and not info.vis) then
                if placingheld then
                    holding[heldindex] = nil
                    placingheld = false
                elseif board[px][py].lvl ~= 3 then
                    shop:buy()
                    board[px][py]:merge()
                    selected = ''
                end
            elseif not board[px][py].sprite and #towerpos >= maxtowers then
                text['Max Towers'].vis = true
            end
        elseif px >= 1 and px <= #board and py >= 1 and py <= #board[1] and not (x > info.x and x < info.x + info.w and y > info.y and y < info.y + info.h and info.vis) 
        and not (x > info.x and x < info.x + info.w and y > info.y and y < info.y + 20 and not info.vis) then
            if remove and board[px][py].obj then
                money = money + board[px][py].lvl
                if board[px][py].name == 'rent' then
                    for i=board[px][py].lvl, 1, -1 do
                        if i == 1 then break end

                        local gonna_hold = math.random(1, #towerpos)
                        while towerpos[gonna_hold] == {px, py} do
                            gonna_hold = math.random(1, #towerpos)
                        end
                        local hx, hy = unpack(towerpos[gonna_hold])
                        table.insert(holding, board[hx][hy])
                        table.remove(towerpos, gonna_hold)
                        board[hx][hy] = {ground = sprites.grass, name = 'grass', sprite = nil, stand = false}
                    end
                    maxtowers = maxtowers - board[px][py].lvl
                end
                board[px][py] = {ground = sprites.grass, name = 'grass', sprite = nil, stand = false}
                --for i=#towerpos, 1, -1 do if towerpos[i] == {px, py} then table.remove(towerpos, i) end end
                remove = false
            elseif board[px][py].obj then
                info.selected = board[px][py].name
                if info.selected == 'shapeshifter' then
                    info.selected = board[px][py].tower.name
                end
                info.h = #names[board[px][py].name].levels[board[px][py].lvl]*25+30
                info.level = board[px][py].lvl
            end
        end

        if #holding ~= 0 then
            local rect = {x = 10, y = 200-32, w = 95, h = 42*(#holding+1)+10}
            for i, v in pairs(holding) do
                if x > rect.x+rect.w/2-16 and x < rect.x+rect.w/2+16 and y > rect.y+42*(i) and y < rect.y+42*(i+1) then
                    selected = v.name
                    placingheld = true
                    heldindex = i
                end
            end
        end
    else
        settings.mousepressed()
    end
end

function game.keypressed(key)
    if key == 'space' and not paused then
        shop:roll()
        selected = ''
    end
    if key == 'p' or key == 'escape' then paused = true end
    if key == 'f' then fast = not fast end
end

return game