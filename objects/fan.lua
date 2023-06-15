local fan = Tower:extend()

function fan:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.dmg = 0
            self.firerate = 5
            self.shootingdur = 1.5
            self.bspd = todt(4)
            self.stats = {
                ratedur = 0.5,
                push = todt(0.4),
                range = self.range
            }
        end,
        function () self.range = 3*32
            self.dmg = 0
            self.firerate = 4
            self.shootingdur = 2.5
            self.bspd = todt(4)
            self.stats = {
                ratedur = 0.6,
                push = todt(0.5),
                range = self.range
            }
        end,
        function () self.range = 4*32
            self.dmg = 0
            self.bspd = todt(4)
            self.stats = {
                ratedur = 0.8,
                push = todt(0.8),
                range = self.range
            }
        end,  
    }

    fan.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.timer = 0
    self.shootingtimer = self.shootingdur
    self.shooting = false
    self.canshoot = true
    self.cutaudio = false
    self.effect = 'push'
    self.rdir = 0
    self.tdir = 0
end

function fan:update(dt, enemies)
    if self.shooting then
        self.shootingtimer = self.shootingtimer - dt
        table.insert(bullets, self:shoot())
        if self.shootingtimer <= 0 then
            self.shooting = false
        end
    else
        self.shootingtimer = self.shootingtimer + dt
        if self.shootingtimer >= self.firerate then
            self.shootingtimer = self.shootingdur
            self.shooting = true
        end
    end

    fan.super.update(self, dt, enemies)
end

function fan:draw(x, y)
    self.rdir = self.rdir + 0.01*(self.lvl*2)
    fan.super.draw(self, x, y)
end

function fan:shoot()
    self:playsound()
    for _=1, 1 do
        local g = randfloat(0.7, 1)
        particles:newparticle(self.space[1]+math.random(-8, 8), self.space[2]+math.random(-8, 8), randfloat(2, 5), randfloat(1, 2), self.dir - math.pi/2, false, {g, g, g}, 80*self.range/(1.5*32))
    end
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2, self.bullet, self.dmg, self.bspd, 1.5, true, false, self.unit, self.effect, self.stats)
end


return fan