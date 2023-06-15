local shotgun = Tower:extend()

function shotgun:new(pos, ground, name)
    self.levels = {
        function () self.range = 2*32; self.dmg = 1; self.firerate = 2; self.bspd = todt(3) end,
        function () self.range = 3*32; self.dmg = 1.6; self.firerate = 1.5; self.bspd = todt(4) end,
        function () self.range = 4*32; self.dmg = 4; self.firerate = 0.8; self.bspd = todt(4) end,    
    }

    shotgun.super.new(self, pos, ground, name)
    self.bullet = sprites.pellet

    self.timer = 0
    self.canshoot = true
    self.count = 0
end

function shotgun:shoot()
    self.count = self.count + 1
    if self.count == 7 then self.timer = 0; self.count = 0; self:playsound() else self.timer = self.firerate end
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2 + randfloat(-0.25, 0.25), self.bullet, self.dmg, 
    self.bspd+math.random(todt(1), todt(4)), 1, true, false, self.unit, self.effect, {range = self.range*1.5})
end

return shotgun