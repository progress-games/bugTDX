local energizer = Tower:extend()

function energizer:new(pos, ground, name)
    self.levels = {
        function () self.range = 2*32
            self.dmg = 1
            self.firerate = 0.5
            self.bspd = todt(7)
            self.stats = {
                max = 10,
                dmg = 3
            } end,
        function () self.range = 3*32
            self.dmg = 1
            self.firerate = 0.4
            self.bspd = todt(7)
            self.stats = {
                max = 15,
                dmg = 3
            } end,
        function () self.range = 4*32
            self.dmg = 2
            self.firerate = 0.3
            self.bspd = todt(7)
            self.stats = {
                max = 20,
                dmg = 8
            } end,
    }

    energizer.super.new(self, pos, ground, name)
    self.bullet = sprites.elightning
    self.timer = 0
    self.canshoot = true
    self.effect = 'lightning'
end

return energizer