local hose = Tower:extend()

function hose:new(pos, ground, name)
    self.levels = {
        function () self.range = 3*32
            self.firerate = 1
            self.shootingdur = 1.5
            self.bspd = todt(7) 
            self.stats = {
                speed = todt(0.2),
                range = 3*32,
                ratedur = 3
            }end,
        function () self.range = 4*32
            self.firerate = 0.7
            self.shootingdur = 1.9
            self.bspd = todt(8)
            self.stats = {
                speed = todt(0.5),
                range = 4*32,
                ratedur = 3
            } end,
        function () self.range = 5*32
            self.firerate = 0.5
            self.shootingdur = 2.2
            self.bspd = todt(9) 
            self.stats = {
                speed = todt(1),
                range = 5*32,
                ratedur = 4
            } end,    
    }

    self.dmg = 0
    hose.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.shooting = false
    self.shootingtimer = 0
    self.timer = 0
    self.canshoot = true
    self.cutaudio = false
    self.effect = 'wet'
end

function hose:update(dt, enemies)
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

    hose.super.update(self, dt, enemies)
end

function hose:shoot()
    self:playsound()
    for _=1, 4 do
        particles:newparticle(self.space[1], self.space[2], randfloat(2, 5), randfloat(1, 2), self.dir - math.pi/2, false, {(102+math.random(-10, 10))/255, (153+math.random(-10, 10))/255, (204+math.random(-10, 10))/255}, 80)
    end
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2, self.bullet, self.dmg, self.bspd, randfloat(0.8, 1.2), true, false, self.unit, self.effect, self.stats)
end

return hose