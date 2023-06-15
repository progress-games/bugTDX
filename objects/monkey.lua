local monkey = Tower:extend()

function monkey:new(pos, ground, name)
    self.levels = {
        function () self.range = 4*32; self.dmg = 1.5; self.firerate = 0.8; self.bspd = todt(7) end,
        function () self.range = 4*32; self.dmg = 1.5; self.firerate = 0.8; self.bspd = todt(7) end,
        function () self.range = 4*32; self.dmg = 1.5; self.firerate = 0.8; self.bspd = todt(7) end,
    }

    monkey.super.new(self, pos, ground, name)
    self.bullet = sprites.dart
    self.timer = 0
    self.canshoot = true
end

return monkey