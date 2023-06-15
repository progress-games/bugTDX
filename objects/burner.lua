local burner = Tower:extend()

function burner:new(pos, ground, name)
    self.levels = {
        function () 
            self.range = 1.5*32
            self.dmg = 0.05
            self.stats = {
                dmg = 0.45,
                rate = 0.5,
                ratetimer = 0.2,
                range = 1.5*32,
                ratedur = 4
            }
        end,
        function () 
            self.range = 2.5*32
            self.dmg = 0.15
            self.stats = {
                dmg = 0.8,
                rate = 0.45,
                ratetimer = 0.2,
                range = 2.5*32,
                ratedur = 6
            }
        end,
        function () 
            self.range = 3.5*32
            self.dmg = 0.35
            self.stats = {
                dmg = 1.6,
                rate = 0.4,
                ratetimer = 0.2,
                range = 3.5*32,
                ratedur = 8
            }
        end,  
    }
    self.firerate = 0.01
    self.bspd = todt(2)
    burner.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.timer = 0
    self.canshoot = true
    self.bdir = 2
    self.effect = 'burn'
    self.cutaudio = false
end

function burner:shoot()
    self.bdir = self.bdir + 1
    if self.bdir == 4 then self.bdir = 0 end
    for _=1, 4 do
        local g, x, y = randfloat(0, 0.2), 0, 0
        if self.bdir == 0 or self.bdir == 2 then y = math.random(-2, 2)
        else x = math.random(-2, 2) end
        particles:newparticle(self.space[1] + x, self.space[2] + y, randfloat(2, 5), randfloat(1, 2), self.bdir*math.pi/2, false, {randfloat(0.7, 1)+g, g, 0}, 25*(self.range/(1.5*32)))
    end

    self:playsound()
    return Bullet(self.space[1]+randfloat(-4, 4), self.space[2] + randfloat(-4, 4), self.bdir*math.pi/2, self.bullet, self.dmg, self.bspd, randfloat(0.8, 1.2), true, false, self.unit, self.effect, self.stats)
end

return burner