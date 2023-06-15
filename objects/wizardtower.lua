local wizardtower = Tower:extend()

function wizardtower:new(pos, ground, name)
    self.levels = {
        function () self.range = 2*32
            self.dmg = 1
            self.firerate = 0.8
            self.bspd = todt(7)
            self.stats = {
                max = 4,
                dmg = 4
            } end,
        function () self.range = 3*32
            self.dmg = 3
            self.firerate = 0.8
            self.bspd = todt(7)
            self.stats = {
                max = 12,
                dmg = 5
            } end,
        function () self.range = 4*32
            self.dmg = 5
            self.firerate = 0.8
            self.bspd = todt(7)
            self.stats = {
                max = 20,
                dmg = 7
            } end,
    }

    wizardtower.super.new(self, pos, ground, name)
    self.bullet = sprites.lightningball
    self.timer = 0
    self.canshoot = true
    self.effect = 'lightning'
end

function wizardtower:draw(x, y)
    self.dir = 0
    wizardtower.super.draw(self, x, y)
end

return wizardtower