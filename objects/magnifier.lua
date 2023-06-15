local magnifier = Tower:extend()

function magnifier:new(pos, ground, name)
    self.levels = {
        function () self.range = 4*32
            self.dmg = 0.04
            self.bspd = todt(7)
            self.stats = {
                dmg = 0.2,
                rate = 0.4,
                ratetimer = 0.2,
                ratedur = 3
            }
        end,
        function () self.range = 4*32
            self.dmg = 0.12
            self.bspd = todt(7)
            self.stats = {
                dmg = 0.4,
                rate = 0.4,
                ratetimer = 0.2,
                ratedur = 3
            }
        end,
        function () self.range = 4*32
            self.dmg = 0.25
            self.bspd = todt(7)
            self.stats = {
                dmg = 0.6,
                rate = 0.4,
                ratetimer = 0.2,
                ratedur = 3
            }
        end  
    }

    self.firerate = 0.01
    magnifier.super.new(self, pos, ground, name)
    self.bullet = sprites.sunray
    self.timer = 0
    self.canshoot = true
    self.effect = 'burn'
    self.cutaudio = false
end

return magnifier