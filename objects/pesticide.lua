local pesticide = Tower:extend()

function pesticide:new(pos, ground, name)
    self.levels = {
        function () self.range = 3*32
            self.firerate = 1
            self.dmg = 1
            self.shootingdur = 0.4
            self.bspd = todt(7) 
            end,
        function () self.range = 4*32
            self.firerate = 0.7
            self.dmg = 2
            self.shootingdur = 0.8
            self.bspd = todt(8)
            end,
        function () self.range = 5*32
            self.firerate = 0.5
            self.dmg = 2.5
            self.shootingdur = 1
            self.bspd = todt(9) 
            end,    
    }

    pesticide.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.shooting = false
    self.shootingtimer = 0
    self.timer = 0
    self.canshoot = true
    self.cutaudio = false
    self.effect = 'pesticide'
end

function pesticide:update(dt, enemies)
    no_elites = true
    for _, v in pairs(enemies) do if v.elite then no_elites = false break end end

    if self.shooting then
        self.shootingtimer = self.shootingtimer - dt
        table.insert(bullets, self:shoot())
        if self.shootingtimer <= 0 or no_elites then
            self.shooting = false
        end
    else
        self.shootingtimer = self.shootingtimer + dt
        if self.shootingtimer >= self.shootingdur and not no_elites then
            self:playsound()
            self.shooting = true
        end
    end

    pesticide.super.update(self, dt, enemies)
end

function pesticide:shoot()
    for _=1, 4 do
        g = randfloat(0, 0.2)
        particles:newparticle(self.space[1], self.space[2], randfloat(2, 5), randfloat(1, 2), self.dir - math.pi/2, false, {randrgb(90,211,0)}, 80)
    end
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2, self.bullet, self.dmg, self.bspd, randfloat(0.8, 1.2), true, false, self.unit, self.effect, self.stats)
end

return pesticide