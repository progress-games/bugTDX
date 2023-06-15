local flamethrower = Tower:extend()

function flamethrower:new(pos, ground, name)
    self.levels = {
        function () self.range = 3*32
            self.firerate = 1
            self.dmg = 0.7
            self.shootingdur = 0.8
            self.bspd = todt(7) 
            self.stats = {
                dmg = 1,
                rate = 0.4,
                ratetimer = 0.2,
                ratedur = 3
            }end,
        function () self.range = 4*32
            self.firerate = 0.7
            self.dmg = 0.9
            self.shootingdur = 1.2
            self.bspd = todt(8)
            self.stats = {
                dmg = 3,
                rate = 0.4,
                ratetimer = 0.2,
                ratedur = 3
            } end,
        function () self.range = 5*32
            self.firerate = 0.5
            self.dmg = 1.5
            self.shootingdur = 1.6
            self.bspd = todt(9) 
            self.stats = {
                dmg = 8,
                rate = 0.4,
                ratetimer = 0.2,
                ratedur = 3
            } end,    
    }

    flamethrower.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.shooting = false
    self.shootingtimer = 0
    self.timer = 0
    self.canshoot = true
    self.effect = 'burn'
    self.cutaudio = false
end

function flamethrower:update(dt, enemies)
    if self.shooting then
        self.shootingtimer = self.shootingtimer - dt
        table.insert(bullets, self:shoot())
        if self.shootingtimer <= 0 then
            self.shooting = false
        end
    else
        self.shootingtimer = self.shootingtimer + dt
        if self.shootingtimer >= self.shootingdur then
            self.shooting = true
        end
    end

    flamethrower.super.update(self, dt, enemies)
end

function flamethrower:shoot()
    self:playsound()
    for _=1, 4 do
        g = randfloat(0, 0.2)
        particles:newparticle(self.space[1], self.space[2], randfloat(2, 5), randfloat(1, 2), self.dir - math.pi/2, false, {randfloat(0.7, 1)+g, g, 0}, 80)
    end
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2, self.bullet, self.dmg, self.bspd, randfloat(0.8, 1.2), true, false, self.unit, self.effect, self.stats)
end

return flamethrower