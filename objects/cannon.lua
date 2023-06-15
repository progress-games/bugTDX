local cannon = Tower:extend()

function cannon:new(pos, ground, name)
    self.levels = {
        function () 
            self.range = 2*32
            self.dmg = 1.5
            self.firerate = 1.2
            self.bspd = todt(3)
            self.stats = {
                radius = 40,
                dmg = 0.5
            } end,
        function () 
            self.range = 3*32
            self.dmg = 1
            self.firerate = 1.1
            self.bspd = todt(3)
            self.stats = {
                radius = 60,
                dmg = 1
            } end,
        function () 
            self.range = 4*32
            self.dmg = 3
            self.firerate = 1
            self.bspd = todt(4)
            self.stats = {
                radius = 90,
                dmg = 1
            } end,   
    }

    cannon.super.new(self, pos, ground, name)
    self.bullet = sprites.ball
    self.timer = 0
    self.canshoot = true
    self.effect = 'explode'
end

function cannon:shoot()
    self:playsound()
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2, self.bullet, self.dmg, self.bspd, 1.3, true, false, self.unit, self.effect, self.stats)
end

return cannon