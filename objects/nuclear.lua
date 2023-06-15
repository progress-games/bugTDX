local nuclear = Tower:extend()

function nuclear:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.dmg = 7
            self.firerate = 1
            self.bspd = todt(7)
            self.stats = {
                radius = 30,
                dmg = 0.3,
                ratedur = 2
            }
         end,
        function () self.range = 3*32
            self.dmg = 15
            self.firerate = 0.8
            self.bspd = todt(7)
            self.stats = {
                radius = 45,
                dmg = 0.6,
                ratedur = 2
            }
         end,
        function () self.range = 4*32
            self.dmg = 15
            self.firerate = 0.6
            self.bspd = todt(7)
            self.stats = {
                radius = 60,
                dmg = 0.9,
                ratedur = 2
            }
         end,    
    }

    nuclear.super.new(self, pos, ground, name)

    self.bullet = sprites.barrel
    self.timer = 0
    self.canshoot = true
    self.effect = 'radiate'
end

function nuclear:draw(x, y)
    self.dir = 0
    nuclear.super.draw(self, x, y)
end

return nuclear