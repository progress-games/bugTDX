local lmg = Tower:extend()

function lmg:new(pos, ground, name)
    self.levels = {
        function () 
            self.range = 4*32
            self.dmg = 0.8
            self.firerate = 0.2
            self.bspd = todt(7) end,
        function () self.range = 5*32
            self.dmg = 1
            self.firerate = 0.1
            self.bspd = todt(8) end,
        function () self.range = 6*32
            self.dmg = 1.1
            self.firerate = 0.05
            self.bspd = todt(9)
            self.unit = 'ground/air'
         end,    
    }

    lmg.super.new(self, pos, ground, name)
    self.bullet = sprites.pellet
    self.timer = 0
    self.canshoot = true
end

function lmg:shoot()
    self:playsound()
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2 + (math.random()*math.random(-1, 1))/5, self.bullet, self.dmg, self.bspd, 1, true, false, self.unit, self.effect, self.stats)
end

return lmg