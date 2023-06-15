local enemy = Object:extend()

function enemy:new(path, x, y, name)
    self.path = path
    if #self.path == 16 + math.floor(16 / 3) then
        table.insert(self.path, {self.path[#self.path][1]+32, self.path[#self.path][2]})
    elseif #self.path == 8 + math.floor(8 / 3) then
        table.insert(self.path, {self.path[#self.path][1], self.path[#self.path][2]+32})
    end
    self.x = x - 16
    self.y = y
    self.basespeed = bugs[name].speed*difficulty[config.difficulty+1].speed
    self.speed = self.basespeed
    self.target = {x = centre.x - 8*32 + path[1][1]*32 - 16 + math.random(-4, 4), y = centre.y - 4*32 + path[1][2]*32 + - 16 + math.random(-4, 4), p = 1}
    self.dir = math.atan2(self.y - self.target.y, self.x - self.target.x) + math.pi
    self.hp = bugs[name].hp*difficulty[config.difficulty+1].health
    if effects.buff.on then self.hp = self.hp * effects.buff.increase end
    if effects.swarm.on then self.hp = self.hp * 0.5 end
    --self.hp = 1
    self.maxhp = self.hp
    self.unit = bugs[name].unit
    self.sprite = sprites[name]
    self.name = name
    self.audiolastplayed = 0
    self.scale = 1
    self.flash = {
        dur = 0.1,
        timer = 0,
        status = false
    }
    self.effects = {}
    self.elite = false
end

function enemy:update(dt)
    self.audiolastplayed = self.audiolastplayed - dt
    if effects.wings.on then
        self.unit = 'air'
    else
        self.unit = bugs[self.name].unit
    end
    local c = self.basespeed
    for e, s in pairs(self.effects) do
        if e == 'burn' or e == 'lava' or e == 'flamingoil' then
            s.ratetimer = s.ratetimer - dt
            if s.ratetimer <= 0 then
                if self.effects['burn mult'] then
                    if math.sqrt((self.x-self.effects['burn mult'].pos[1])^2+(self.y - self.effects['burn mult'].pos[2])^2) <= self.effects['burn mult'].radius then
                        self:takedmg(s.dmg*self.effects['burn mult'].mult)
                        s.ratetimer = s.rate
                    else
                        self:takedmg(s.dmg)
                        s.ratetimer = s.rate
                    end
                else
                    self:takedmg(s.dmg)
                    s.ratetimer = s.rate
                end
            end
            s.ratedur = s.ratedur - dt
            if s.ratedur <= 0 then self.effects['burn'] = nil end
        end
        if e == 'oil' then
            c = c - s.slow
            if self.speed == 0 then self.speed = todt(0.05) end
            s.ratetimer = s.ratetimer - dt
            if s.ratetimer <= 0 then
                self:takedmg(s.dmg)
                s.ratetimer = s.rate
            end
            s.ratedur = s.ratedur - dt
            if s.ratedur <= 0 then self.effects['oil'] = nil; self.speed = self.basespeed end
        end
        if e == 'wet' then
            c = c + s.speed
            s.ratedur = s.ratedur - dt
            if s.ratedur <= 0 then self.effects['wet'] = nil end
        end
        if e == 'teleport' then
            self.x = centre.x - 8*32 + self.path[1][1]*32 - 64
            self.y = centre.y - 4*32 + self.path[1][2]*32 - 16 
            self.target = {x = centre.x - 8*32 + self.path[1][1]*32 - 16, y = centre.y - 4*32 + self.path[1][2]*32 - 16, p = 1}
            self.effects['teleport'] = nil
        end
        if e == 'slow' then
            c = c - s.slow
            s.ratedur = s.ratedur - dt
            if s.ratedur <= 0 then self.effects['slow'] = nil; self.speed = self.basespeed end
        end
        if c < 0 then c = 0 end
        if e == 'push' then 
            c = c/10 - s.push
            s.ratedur = s.ratedur - dt
            if s.ratedur <= 0 then self.effects['push'] = nil; self.speed = self.basespeed end
        end
        if e == 'freeze' then
            c = 0 
            s.ratedur = s.ratedur - dt
            if s.ratedur <= 0 then 
                self.effects['freeze'] = nil
                self.speed = self.basespeed
                if not self.effects['slow'] then
                    self.effects['slow'] = {
                        ratedur = 2,
                        slow = todt(0.1)
                    }
                else
                    self.effects['slow'].ratedur = self.effects['slow'].ratedur + 1
                end
            end
        end
        if e == 'weaken' then
            s.ratedur = s.ratedur - dt
            if s.ratedur <= 0 then self.effects['weaken'] = nil end
        end
        if e == 'pull' then
            s.ratedur = s.ratedur - dt
            if s.ratedur <= 0 then 
                self.effects['pull'] = nil
                i = 1
                for k, v in pairs(self.path) do
                    local dis = math.sqrt((self.y-(centre.y-4*32+v[2]*32-16))^2+(self.x-(centre.x-8*32+v[1]*32-16))^2)
                    if dis < math.sqrt((self.y-(centre.y-4*32+self.path[i][2]*32-16))^2+(self.x-(centre.x-8*32+self.path[i][1]*32-16))^2) then
                        i = k
                    end
                end
                self.target.p = i
                self.target.x = centre.x - 8*32 + self.path[self.target.p][1]*32 - 16 + math.random(-4, 4)
                self.target.y = centre.y - 4*32 + self.path[self.target.p][2]*32 - 16 + math.random(-4, 4)
            end
        end
        if e == 'ground' then
            s.ratedur = s.ratedur - dt
            self.unit = 'ground'
            if s.ratedur <= 0 then self.effects['ground'] = nil; self.unit = bugs[self.name].unit end
        end
        if e == 'radiate' then
            s.ratedur = s.ratedur - dt
            if s.ratedur <= 0 then self.effects['radiate'] = nil
            else
                for _, v in pairs(enemies) do
                    if v.x ~= self.x and v.y ~= self.y then
                        if math.sqrt((v.x-self.x)^2+(v.y-self.y)^2) <= 4*(s.radius/32) then
                            v:takedmg(s.dmg)
                        end
                    end
                end
            end
        end
        if e == 'electrocution' then
            c = c + todt(math.random(-1, 1))
            s.ratetimer = s.ratetimer - dt
            if s.ratetimer <= 0 then
                self:takedmg(s.dmg)
                s.ratetimer = s.rate
            end
            s.ratetimer = s.ratetimer - dt
            if s.ratedur <= 0 then self.effects['electrocution'] = nil end
        end
        if e == 'detonator' then
            s.ratedur = s.ratedur - dt
            if s.ratedur <= 0 then
                self:takedmg(s.dmg, 'none', {})
                for _=1, 5 + s.radius do
                    local g = randfloat(0, 0.2)
                    particles:newparticle(self.x + math.random(-s.radius/2, s.radius/2),
                    self.y + math.random(-s.radius/2, s.radius/2), randfloat(15, 25), 
                    randfloat(0.1, 0.5), randfloat(0, 2*math.pi), false, {randfloat(0.7, 1)+g, g, 0}, 10)
                end
                for p, m in pairs(enemies) do
                    if math.sqrt((self.x-m.x)^2+(self.y-m.y)^2) <= s.radius and i ~= p then
                        m:takedmg(s.edmg, 'none', {})
                    end
                end
                self.effects['detonator'] = nil
            end
        end
        if e == 'regen' then
            s.ratedur = s.ratedur - dt
            s.ratetimer = s.ratetimer - dt
            if s.ratetimer <= 0 then s.ratetimer = 0.5; self.hp = math.max(self.hp + s.hp, self.maxhp) end
            if s.ratedur <= 0 then self.effects['regen'] = nil end
        end
        if e == 'confusion' then
            s.rate = s.rate - dt
            if s.rate <= 0 then self.effects['confusion'] = nil end
        end
        if e == 'stone' then
            c = c - s.slow
            self.hp = self.hp + s.regen
            s.rate = s.rate - dt
            if s.rate <= 0 then self.effects['stone'] = nil end
        end
    end
    if effects.speed.on then c = c * effects.speed.increase end
    self.speed = c

    if self.x > self.target.x - 3 and self.x < self.target.x + 3 and 
    self.y > self.target.y - 3 and self.y < self.target.y + 3 and self.target.p <= #self.path then
        self.target.p = self.target.p + 1
        self.target.x = centre.x - 8*32 + self.path[self.target.p][1]*32 - 16 + math.random(-4, 4)
        self.target.y = centre.y - 4*32 + self.path[self.target.p][2]*32 - 16 + math.random(-4, 4)
    else
        self.dir = math.atan2(self.y - self.target.y, self.x - self.target.x) + math.pi
        if self.effects['pull'] then 
            self.pdir = math.atan2(self.y-self.effects['pull'].pos[2], self.x-self.effects['pull'].pos[1]) + math.pi
            self.x = self.x + self.effects['pull'].strength*math.cos(self.pdir)*dt
            self.y = self.y + self.effects['pull'].strength*math.sin(self.pdir)*dt
        else
            if self.effects['confusion'] then
                self.x = self.x + self.speed*math.cos(self.dir+math.random(-1, 1))*dt
                self.y = self.y + self.speed*math.sin(self.dir+math.random(-1, 1))*dt
            else
                self.x = self.x + self.speed*math.cos(self.dir)*dt
                self.y = self.y + self.speed*math.sin(self.dir)*dt
            end
        end
    end

    self.flash.timer = self.flash.timer + dt
    if self.flash.timer > self.flash.dur then self.flash.status = false end

    if self.x > centre.x + 8*32 or self.y > centre.y + 4*32 or self.hp < 0.5 then
        if self.target.p == #self.path then
            pass = pass - 1
            play('loselife')
            damage_taken = true
        else
            play('enemydead')
        end
        return true 
    else return false end
end

function enemy:takedmg(dmg, effect, stats)
    if effect == 'speed' then 
        dmg = dmg + dmg*(self.speed*stats.mult/60)
        effect = 'none' 
    end
    if self.effects['weaken'] then
        dmg = dmg*self.effects['weaken'].mult 
        effect = 'none'
    end
    if effects == 'shred' then 
        local a = true
        for k, v in pairs(self.effects) do
            if k ~= 'none' and k ~= 'shred' then a = false end
        end
        if a then dmg = dmg*stats.mult end
        effect = 'none'
    end
    if effect == 'radiate' and self.effects['radiate'] ~= nil then 
        dmg = dmg/4
        effect = 'none'
    end
    if effect == 'afflict' then 
        dmg = dmg + #self.effects*stats.mult
        effect = 'none'
    end
    if (effect == 'shock' and self.effects['water']) or (effect == 'water' and self.effects['shock']) then 
        effect = 'electrocution'
        stats = {
            dmg = 2,
            ratedur = 0.5,
            rate = 0.5,
            ratetimer = 2
        }
    end
    if (self.effects['burn'] and effect == 'oil') or (self.effects['oil'] and effect == 'burn') then
        self.effects['flamingoil'] = {
            dmg = 8,
            ratedur = 2,
            ratetimer = 0.1,
            rate = 1
        }
    end
    if (self.effects['water'] and effect == 'lava') or (self.effects['lava'] and effect == 'water') or
    (self.effects['water'] and effect == 'fire') or (self.effects['fire'] and effect == 'water') then
        self.effects['stone'] = {
            slow = todt(0.2),
            regen = 0.01,
            ratedur = 5
        }
    end
    if (self.effects['push'] and effect == 'pull') or ((self.effects['pull'] and effect == 'push')) then
        self.effects['confusion'] = {
            rate = 5
        }
    end
    self.hp = self.hp - dmg
    self.flash.timer = 0
    self.flash.status = true
    if effect then
        if effect ~= 'explode' and effect ~= 'none' then
            self.effects[effect] = table.copy(stats)
        end
    end
    if self.audiolastplayed <= 0 and dmg ~= 0 then
        play('takedmg')
        self.audiolastplayed = audio.sfx.takedmg:getDuration()*1.5
    end
end

function enemy:draw(x, y)
    if self.effects['radiate'] then 
        love.graphics.setColor(0, 1, 0, 0.4)
        love.graphics.circle('fill', self.x, self.y, self.effects['radiate'].radius)
        love.graphics.setColor(1, 1, 1)
    end
    if self.unit == 'air' then
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.draw(self.sprite, self.x, self.y, self.dir+math.pi/2, 0.5, 0.5, 16, 16)
        love.graphics.setColor(1, 1, 1)
        if self.flash.status then
            love.graphics.setShader(hitflash)
            love.graphics.draw(self.sprite, self.x, self.y-8, self.dir+math.pi/2, 0.5, 0.5, 16, 16)
            love.graphics.setShader()
        else
            love.graphics.draw(self.sprite, self.x, self.y-8, self.dir+math.pi/2, 0.5, 0.5, 16, 16)
        end
    else
        if self.flash.status then
            love.graphics.setShader(hitflash)
            love.graphics.draw(self.sprite, self.x, self.y, self.dir+math.pi/2, 0.5, 0.5, 16, 16)
            love.graphics.setShader()
        else
            love.graphics.draw(self.sprite, self.x, self.y, self.dir+math.pi/2, 0.5, 0.5, 16, 16)
        end
    end
    if #self.effects ~= 0 then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('fill', self.x-4, self.y-21, 17, 5, 3, 3)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', self.x-3, self.y-20, 15, 3, 3, 3)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle('fill', self.x-3, self.y-20, self.hp/(self.maxhp)*15, 3, 3, 3)
        love.graphics.setColor(1, 1, 1)
    else
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('fill', self.x-4, self.y-13, 17, 5, 3, 3)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', self.x-3, self.y-12, 15, 3, 3, 3)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle('fill', self.x-3, self.y-12, self.hp/(self.maxhp)*15, 3, 3, 3)
        love.graphics.setColor(1, 1, 1)
    end
    local i = 1
    for e, s in pairs(self.effects) do
        if e == 'wet' then love.graphics.draw(sprites.water, self.x-8+i*7, self.y - 16)
        elseif e == 'burn' or e == 'lava' then love.graphics.draw(sprites.flame, self.x-8+i*7, self.y - 16)
        elseif e == 'oil' then love.graphics.draw(sprites.oil, self.x-8+i*7, self.y - 16)
        elseif e == 'freeze' then love.graphics.draw(sprites.freeze, self.x-8+i*7, self.y - 16)
        elseif e == 'slow' then love.graphics.draw(sprites.slow, self.x-8+i*7, self.y - 16)
        elseif e == 'push' then love.graphics.draw(sprites.push, self.x-8+i*7, self.y - 16)
        elseif e == 'flamingoil' then love.graphics.draw(sprites.flamingoil, self.x-8+i*7, self.y - 16)
        elseif e == 'weaken' then love.graphics.draw(sprites.fistbullet, self.x-8+i*7, self.y - 16, 0, 0.5, 0.5)
        elseif e == 'poison' then love.graphics.draw(sprites.poisondrop, self.x-8+i*7, self.y - 16, 0, 0.5, 0.5)
        elseif e == 'detonator' then love.graphics.draw(sprites.dynamite, self.x-8+i*7, self.y - 16, 0, 0.5, 0.5)
        elseif e == 'electrocution' then love.graphics.draw(sprites.electrocution, self.x-8+i*7, self.y - 16, 0, 0.5, 0.5)
        elseif e == 'confusion' then love.graphics.draw(sprites.confusion, self.x-8+i*7, self.y - 16, 0, 0.5, 0.5)
        elseif e == 'stone' then love.graphics.draw(sprites.stone, self.x-8+i*7, self.y - 16, 0, 0.5, 0.5) end
        if e ~= 'none' then i = i + 1 end
    end
end

return enemy