local affliction = Tower:extend()

function affliction:new(pos, ground, name)
    self.levels = {
        function () self.range = 4*32; self.dmg = 8; self.firerate = 1.3; self.bspd = todt(7); self.stats = {mult = 1.1} end,
        function () self.range = 5*32; self.dmg = 12; self.firerate = 1.1; self.bspd = todt(8); self.stats = {mult = 1.3} end,
        function () self.range = 7*32; self.dmg = 15; self.firerate = 1; self.bspd = todt(9); self.stats = {mult = 1.5} end,    
    }

    affliction.super.new(self, pos, ground, name)
    self.bullet = sprites.bone
    self.timer = 0
    self.effect = 'afflict'
    self.canshoot = true
end

return affliction