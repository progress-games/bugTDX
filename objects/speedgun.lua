local speedgun = Tower:extend()

function speedgun:new(pos, ground, name)
    self.levels = {
        function () self.range = 2.5*32; self.dmg = 1; self.firerate = 1; self.bspd = todt(9); self.stats = {mult = 2} end,
        function () self.range = 5*32; self.dmg = 1.5; self.firerate = 0.8; self.bspd = todt(11); self.stats = {mult = 3} end,
        function () self.range = 6*32; self.dmg = 2; self.firerate = 0.7; self.bspd = todt(15); self.stats = {mult = 6} end,    
    }

    speedgun.super.new(self, pos, ground, name)
    self.bullet = sprites.laser
    self.timer = 0
    self.canshoot = true
    self.effect = 'speed'
end

return speedgun