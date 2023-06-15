local detonator = Tower:extend()

function detonator:new(pos, ground, name)
    self.levels = {
        function () self.range = 4.5*32
            self.dmg = 2
            self.firerate = 0.8
            self.bspd = todt(7)
            self.stats = {
                freq = 5,
                dmg = 10,
                ratedur = 5,
                edmg = 2,
                radius = 30
            }
        end,
        function () self.range = 6*32
            self.dmg = 4
            self.firerate = 0.7
            self.bspd = todt(8)
            self.stats = {
                freq = 3,
                dmg = 14,
                ratedur = 5,
                edmg = 4,
                radius = 40
            }
        end,
        function () self.range = 8*32
            self.dmg = 6
            self.firerate = 0.5
            self.bspd = todt(9)
            self.stats = {
                freq = 3,
                dmg = 18,
                ratedur = 5,
                edmg = 8,
                radius = 50
            }
        end,
    }

    detonator.super.new(self, pos, ground, name)
    self.bullet = sprites.dynamite
    self.timer = 0
    self.canshoot = true
    self.effect = 'detonator'
end

function detonator:update(dt, enemies)
    self.stats.ratedur = self.stats.ratedur - dt
    if self.stats.ratedur <= 0 then self.stats.ratedur = self.stats.freq end
    return detonator.super.update(self, dt, enemies) 
end

function detonator:draw(x, y)
    self.dir = 0
    detonator.super.draw(self, x, y)
end

return detonator