local crossbow = Tower:extend()

function crossbow:new(pos, ground, name)
    self.levels = {
        function () self.range = 4*32; self.dmg = 1.5; self.firerate = 1.1; self.bspd = todt(7) end,
        function () self.range = 5*32; self.dmg = 3.5; self.firerate = 0.8; self.bspd = todt(8) end,
        function () self.range = 7*32; self.dmg = 6; self.firerate = 0.5; self.bspd = todt(9) end,    
    }

    crossbow.super.new(self, pos, ground, name)
    self.bullet = sprites.arrow
    self.timer = 0
    self.canshoot = true
end

return crossbow