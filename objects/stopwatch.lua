local stopwatch = Tower:extend()

function stopwatch:new(pos, ground, name)
    self.levels = {
        function () 
            self.range = math.huge
            self.stats = {
                ratedur = 1
            }
            self.firerate = 5 end,
        function () 
            self.stats = {
                ratedur = 2.5
            }
            self.firerate = 5 end,
        function () 
            self.stats = {
                ratedur = 3.8
            }
            self.firerate = 5 end,  
    }

    stopwatch.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.timer = 0
    self.effect = 'freeze'
    self.canshoot = true
end

function stopwatch:draw(x, y)
    self.dir = 0
    stopwatch.super.draw(self, x, y)
end

function stopwatch:shoot()
    self:playsound()
    for i=1, 50 do
        particles:newparticle(math.random(centre.x-8*32, centre.x+8*32), math.random(centre.y-4*32, centre.y+4*32), 
        randfloat(4, 15), 0, 0, false, {(173+math.random(-10, 10))/255, (216+math.random(-10, 10))/255, (230+math.random(-10, 10))/255}, 20)
    end
    if #enemies ~= 0 then
        for _, e in pairs(enemies) do
            if e.x > centre.x - 8*32 and e.x < centre.x + 8*32 and e.y > centre.y - 4*32 and e.y < centre.y + 4*32 then
                e:takedmg(0, self.effect, self.stats)
            end
        end
    end
    return Bullet(self.space[1], self.space[2], self.dir - math.pi/2, self.bullet, 0, 0, 100, true, false, self.unit, self.effect, {ratedur = 0})
end

return stopwatch