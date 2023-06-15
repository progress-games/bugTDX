local weight = Tower:extend()

function weight:new(pos, ground, name)
    self.levels = {
        function () self.range = 3*32
            self.stats = {
                ratedur = 3
            }
            self.dmg = 3
            self.firerate = 1
            self.bspd = todt(3) end,
        function () self.range = 4*32
            self.stats = {
                ratedur = 4
            }
            self.dmg = 6
            self.firerate = 0.8
            self.bspd = todt(3) end,
        function () self.range = 5*32
            self.stats = {
                ratedur = 5
            }
            self.dmg = 10
            self.firerate = 0.4
            self.bspd = todt(3) end, 
    }

    weight.super.new(self, pos, ground, name)
    self.bullet = sprites.weightb
    self.timer = 0
    self.canshoot = true
    self.effect = 'ground'
end

return weight