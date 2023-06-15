local bazooka = Tower:extend()

function bazooka:new(pos, ground, name)
    self.levels = {
        function () 
            self.range = 6*32
            self.dmg = 6
            self.firerate = 5
            self.bspd = todt(1)
            self.stats = {
                radius = 120,
                dmg = 2
            } end,
        function () 
            self.range = 7*32
            self.dmg = 10
            self.firerate = 4
            self.bspd = todt(3)
            self.stats = {
                radius = 240,
                dmg = 4
            } end,
        function () 
            self.range = 11*32
            self.dmg = 14
            self.firerate = 3
            self.bspd = todt(5)
            self.stats = {
                radius = 480,
                dmg = 12
            } end,   
    }

    bazooka.super.new(self, pos, ground, name)
    self.bullet = sprites.rocket
    self.timer = 0
    self.canshoot = true
    self.effect = 'explode'
end

function bazooka:shoot()
    self:playsound()
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2, self.bullet, self.dmg, self.bspd, 2, true, false, self.unit, self.effect, self.stats)
end

return bazooka