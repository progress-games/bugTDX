local blackhole = Tower:extend()

function blackhole:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.dmg = 0
            self.firerate = 4
            self.bspd = todt(4)
            self.stats = {
                ratedur = 0.1,
                pos = {self.space[1], self.space[2]},
                strength = todt(0.6)
            }
            self.shootingdur = 1
        end,
        function () self.range = 3*32
            self.dmg = 0
            self.firerate = 3
            self.bspd = todt(4)
            self.stats = {
                ratedur = 0.1,
                pos = {self.space[1], self.space[2]},
                strength = todt(0.7)
            }
            self.shootingdur = 2
        end,
        function () self.range = 6*32
            self.dmg = 0
            self.firerate = 2
            self.bspd = todt(4)
            self.stats = {
                ratedur = 0.1,
                pos = {self.space[1], self.space[2]},
                strength = todt(1)
            }
            self.shootingdur = 4
        end,  
    }

    blackhole.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.timer = 0
    self.shootingtimer = self.shootingdur
    self.shooting = false
    self.canshoot = true
    self.effect = 'pull'
    self.cutaudio = false
    self.rdir = 0
end

function blackhole:update(dt, enemies)
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

    blackhole.super.update(self, dt, enemies)
end

function blackhole:draw(x, y)
    self.rdir = self.rdir + 0.01
    self.dir = self.rdir
    blackhole.super.draw(self, x, y)
    --love.graphics.circle('fill', self.space[1], self.space[2], 10)
end

function blackhole:shoot()
    self:playsound()
    for _=1, 3 do
        local c, x, y = randfloat(0, 0.2), self.space[1]+math.random(-self.range, self.range), self.space[2]+math.random(-self.range, self.range)
        local dir = math.atan2(y-self.space[2], x-self.space[1])
        particles:newparticle(x, y, randfloat(0.5, 2), randfloat(0.5, 0.8), dir + math.pi, false, {c, c, c}, 130*(self.shootingdur/2))
    end
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2, self.bullet, self.dmg, 0, self.range/8, true, false, self.unit, self.effect, self.stats)
end


return blackhole