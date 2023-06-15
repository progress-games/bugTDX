local cloud = Tower:extend()

function cloud:new(pos, ground, name)
    self.levels = {
        function () self.range = 4*32
            self.dmg = 0.7
            self.stats = {
                speed = todt(0.2),
                ratedur = 1.5
            }
            self.firerate = 0.3
            self.bspd = todt(7)
         end,
        function () self.range = 5*32
            self.dmg = 1.2
            self.firerate = 0.3
            self.bspd = todt(8)
            self.effect = 'lightningw'
            self.stats = {
                speed = todt(0.3),
                ratedur = 1.5,
                dmg = 1,
                max = 6
            }
        end,
        function () self.range = 5*32
            self.dmg = 3
            self.firerate = 0.3
            self.bspd = todt(8)
            self.effect = 'lightningw'
            self.stats = {
                speed = todt(0.5),
                ratedur = 1.5,
                dmg = 1,
                max = 12
            }
        end, 
    }

    cloud.super.new(self, pos, ground, name)
    self.bullet = sprites.waterdrop
    self.timer = 0
    self.canshoot = true
    self.effect = 'wet'
end

return cloud