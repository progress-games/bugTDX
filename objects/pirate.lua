local pirate = Tower:extend()

function pirate:new(pos, ground, name)
    self.levels = {
        function () self.range = 4*32
            self.dmg = 1.5
            self.firerate = 0.8
            self.basedmg = self.dmg
            self.bspd = todt(7)
            self.moneymult = 2 end,
        function () self.range = 4*32
            self.dmg = 1.5
            self.firerate = 0.8
            self.basedmg = self.dmg
            self.bspd = todt(7)
            self.moneymult = 4 end,
        function () self.range = 4*32
            self.dmg = 1.5
            self.firerate = 0.8
            self.basedmg = self.dmg
            self.bspd = todt(7)
            self.moneymult = 6 end,
    }

    pirate.super.new(self, pos, ground, name)
    self.bullet = sprites.coin
    self.timer = 0
    self.canshoot = true
end

function pirate:endbuy()
    self.dmg = self.basedmg + money*self.moneymult
end

return pirate