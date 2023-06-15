local tower = Object:extend()

function tower:new(pos, ground, name)
    self.pos = {pos[1], pos[2]}
    self.space = {pos[1]*32 + (centre.x - 8*32) - 16, pos[2]*32 + (centre.y - 4*32) - 16}
    self.lvl = 1
    self.ground = ground
    self.obj = true
    self.name = name
    self.tier = names[name].tier
    self.dir = 0
    self.effect = 'none'
    self.stats = {}
    self.unit = names[name].unit
    self.xp = 0
    self.vxp = {
        vis = false,
        dur = 1.5,
        timer = 0
    }
    self.cutaudio = true
    
    self:updatedesc()
end

function tower:move(pos)
    self.pos = {pos[1], pos[2]}
    self.space = {pos[1]*32 + (centre.x - 8*32) - 16, pos[2]*32 + (centre.y - 4*32) - 16}
end

function tower:update(dt, enemies)
    if enemies and #enemies > 0 then
        local e, firsta, firstg = sort(enemies, 'x'), nil, nil

        for i, enemy in pairs(enemies) do
            local dis = math.sqrt((self.space[1]-enemy.x)^2+(self.space[2]-enemy.y)^2)

            if dis <= self.range and enemy.unit == 'air' then firsta = firsta or i
            elseif dis <= self.range and enemy.unit == 'ground' then firstg = firstg or i end
            if firsta and firstg then break end
        end

        if self.unit == 'ground/air' then first = min(firsta, firstg)
        elseif self.unit == 'ground' then first = firstg
        elseif self.unit == 'air' then first = firsta end

        if first then
            self.dir = math.atan2(self.space[2] - e[first].y, self.space[1] - e[first].x) + 3*math.pi/2

            if self.canshoot then
                if self.name ~= 'pot' and self.name ~= 'ritual' and self.name ~= 'volcano' and self.name ~= 'poison'
                and self.name ~= 'spikes' and self.name ~= 'frostedspikes' then self.timer = self.timer + dt end
                if self.timer >= self.firerate then
                    self.timer = 0
                    return 'shoot'
                end
            end
        end
    end
    if self.name == 'pot' or self.name == 'ritual' or self.name == 'volcano' or self.name == 'poison' or
    self.name == 'spikes' or self.name == 'frostedspikes' then 
        self.timer = self.timer + dt 
        if self.timer >= self.firerate then
            self.timer = 0
            return 'shoot'
        end
    end

    if self.vxp.vis then
        self.vxp.timer = self.vxp.timer - dt
        if self.vxp.timer <= 0 then
            self.vxp.vis = false
        end
    end
end

function tower:draw(x, y)
    if x > self.space[1] - 16 and x < self.space[1] + 16 and y > self.space[2] - 16 and y < self.space[2] + 16 then
        love.graphics.circle('line', self.space[1], self.space[2], self.range)
        languages.update_font('desc')
        love.graphics.print(({'I', 'II', 'III'})[self.lvl], self.space[1]-8, self.space[2]-32)
        if self.lvl == 3 then
            love.graphics.print('max xp', self.space[1]-12, self.space[2]+18)
        elseif self.lvl == 2 then
            love.graphics.print(self.xp..'/5 xp', self.space[1]-12, self.space[2]+18)
        elseif self.lvl == 1 then
            love.graphics.print(self.xp..'/3 xp', self.space[1]-12, self.space[2]+18)
        end
    end
    if self.name ~= 'burner' then
        if self.name == 'fan' then
            love.graphics.draw(self.sprite, centre.x+32*(self.pos[1]-9)+16, centre.y+32*(self.pos[2]-5)+16, self.rdir, 1, 1, 16, 16)
        else 
            love.graphics.draw(self.sprite, centre.x+32*(self.pos[1]-9)+16, centre.y+32*(self.pos[2]-5)+16, self.dir, 1, 1, 16, 16)
        end
    else
        love.graphics.draw(self.sprite, centre.x+32*(self.pos[1]-9)+16, centre.y+32*(self.pos[2]-5)+16, 0, 1, 1, 16, 16)
    end
    if self.vxp.vis then
        languages.update_font('desc')
        if self.lvl == 3 then
            love.graphics.print('max xp', self.space[1]-12, self.space[2]+18)
        elseif self.lvl == 2 then
            love.graphics.print(self.xp..'/5 xp', self.space[1]-12, self.space[2]+18)
        elseif self.lvl == 1 then
            love.graphics.print(self.xp..'/3 xp', self.space[1]-12, self.space[2]+18)
        end
    end
end

function tower:shoot()
    self:playsound()
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2, self.bullet, self.dmg, self.bspd, 1, true, false, self.unit, self.effect, self.stats)
end

function tower:playsound()
    if self.cutaudio then
        play(self.name)
    elseif not audio.sfx[self.name]:isPlaying() then
        play(self.name)
    end
end

function tower:updatedesc()
    self.levels[self.lvl]()
    self.sprite = sprites[self.name]
end

function tower:merge()
    self.xp = self.xp + 1
    for i=1, math.random(4, 6) do
        particles:newparticle(self.space[1], self.space[2], randfloat(0.8, 1), randfloat(0.1, 0.2), 
        randfloat(0, 2*math.pi), false, {1, 1, 1}, 50, sprites.plus)
    end
    if self.xp == 3 and self.lvl == 1 then
        play('level')
        self.lvl = self.lvl + 1
        self:updatedesc()
        self.xp = 0
        for i=1, math.random(14, 20) do
            particles:newparticle(self.space[1], self.space[2], randfloat(0.8, 1), randfloat(0.1, 0.2), 
            randfloat(0, 2*math.pi), false, {1, 1, 1}, 50, sprites.plus)
        end
    elseif self.xp == 5 and self.lvl == 2 then
        play('level')
        self.lvl = self.lvl + 1
        self:updatedesc()
        self.xp = 0
        for i=1, math.random(14, 20) do
            particles:newparticle(self.space[1], self.space[2], randfloat(0.8, 1), randfloat(0.1, 0.2), 
            randfloat(0, 2*math.pi), false, {1, 1, 1}, 50, sprites.plus)
        end
    else
        play('merge')
    end
    self.vxp.vis = true
    self.vxp.timer = self.vxp.dur

    if self.lvl == 3 then
        steam.userStats.setAchievement('MAXED OUT')
        steam.userStats.storeStats()
    end
end

return tower