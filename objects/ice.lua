local ice = Tower:extend()

function ice:new(pos, ground, name)
    self.levels = {
        function () self.range = 2*32
            self.dmg = 4
            self.firerate = 1.2
            self.bspd = todt(5)
            self.stats = {
                ratedur = 0.8
            }
        end,
        function () self.range = 3*32
            self.dmg = 8
            self.firerate = 0.9
            self.bspd = todt(5)
            self.stats = {
                ratedur = 1.4
            }
        end,
        function () self.range = 4*32
            self.dmg = 12
            self.firerate = 0.7
            self.bspd = todt(5)
            self.stats = {
                ratedur = 2
            }
        end, 
    }

    ice.super.new(self, pos, ground, name)
    self.bullet = sprites.icebullet
    self.timer = 0
    self.canshoot = true
    self.effect = 'freeze'
end

return ice