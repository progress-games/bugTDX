local tricannon = Tower:extend()

function tricannon:new(pos, ground, name)
    self.levels = {
        function () 
            self.range = 2*32
            self.dmg = 2
            self.firerate = 1
            self.bspd = todt(3)
            self.stats = {
                radius = 40,
                dmg = 0.5
            } end,
        function () 
            self.range = 3*32
            self.dmg = 2
            self.firerate = 0.9
            self.bspd = todt(3)
            self.stats = {
                radius = 80,
                dmg = 1
            } end,
        function () 
            self.range = 4*32
            self.dmg = 6
            self.firerate = 0.7
            self.bspd = todt(4)
            self.stats = {
                radius = 120,
                dmg = 3
            } end,   
    }

    tricannon.super.new(self, pos, ground, name)
    self.bullet = sprites.ball
    self.timer = 0
    self.canshoot = true
    self.effect = 'explode'
end

function tricannon:shoot()
    self:playsound()
    for i=1, 3 do
        table.insert(bullets, Bullet(self.space[1], self.space[2], self.dir - math.pi/2 - (i-2)*math.pi/3, self.bullet, self.dmg, self.bspd, 0.7, true, false, self.unit, self.effect, self.stats))
    end
    return nil
end

return tricannon