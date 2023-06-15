local hand = Tower:extend()

function hand:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.dmg = 5
            self.firerate = 1.5
            self.bspd = todt(3)
            self.stats = {
                mult = 1.5,
                ratedur = 2
            }
        end,
        function () self.range = 1.5*32
            self.dmg = 9
            self.firerate = 1
            self.bspd = todt(3)
            self.stats = {
                mult = 1.7,
                ratedur = 3
            }
        end,
        function () self.range = 1.5*32
            self.dmg = 15
            self.firerate = 0.8
            self.bspd = todt(3)
            self.stats = {
                mult = 2.4,
                ratedur = 5
            }
        end,  
    }

    hand.super.new(self, pos, ground, name)
    self.bullet = sprites.fistbullet

    self.timer = 0
    self.canshoot = true
    self.effect = 'weaken'
end

return hand