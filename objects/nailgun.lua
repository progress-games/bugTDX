local nailgun = Tower:extend()

function nailgun:new(pos, ground, name)
    self.levels = {
        function () self.range = 5*32
            self.dmg = 1
            self.firerate = 0.3
            self.bspd = todt(7)
        self.stats = {
            mult = 4
        } end,
        function () self.range = 6*32
            self.dmg = 1
            self.firerate = 0.2
            self.bspd = todt(8)
        self.stats = {
            mult = 5
        } end,
        function () self.range = 8*32
            self.dmg = 1
            self.firerate = 0.1
            self.bspd = todt(9)
        self.stats = {
            mult = 8
        } end,  
    }

    nailgun.super.new(self, pos, ground, name)
    self.bullet = sprites.nail
    self.timer = 0
    self.canshoot = true
    self.effect = 'shred'
end

return nailgun