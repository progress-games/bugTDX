local laserblaster = Tower:extend()

function laserblaster:new(pos, ground, name)
    self.levels = {
        function () 
            self.range = 1.5*32
            self.dmg = 1
        end,
        function () 
            self.range = 2.5*32
            self.dmg = 1.5
        end,
        function () 
            self.range = 3.5*32
            self.dmg = 4
        end,  
    }
    self.firerate = 0.01
    self.bspd = todt(2)
    laserblaster.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.timer = 0
    self.canshoot = true
    self.bdir = 2
    self.cutaudio = false
end

function laserblaster:draw(x, y)
    self.dir = 0
    laserblaster.super.draw(self, x, y)
end

function laserblaster:shoot()
    self:playsound()
    self.bdir = self.bdir + 1
    if self.bdir == 4 then self.bdir = 0 end
    for _=1, 4 do
        local  x, y =  0, 0
        if self.bdir == 0 or self.bdir == 2 then y = math.random(-2, 2)
        else x = math.random(-2, 2) end
        particles:newparticle(self.space[1] + x, self.space[2] + y, randfloat(4, 6), randfloat(3, 5), self.bdir*math.pi/2, false, {randfloat(0.7, 1), 0, 0}, 15*(self.range/(1.5*32)))
    end
    return Bullet(self.space[1]+randfloat(-4, 4), self.space[2] + randfloat(-4, 4), self.bdir*math.pi/2, self.bullet, self.dmg, self.bspd, randfloat(0.8, 1.2), true, false, self.unit, self.effect, self.stats)
end

return laserblaster