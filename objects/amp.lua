local amp = Tower:extend()

function amp:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.firerate = 0
            self.stats = {
                pos = {self.space[1], self.space[2]},
                mult = 1.5,
                ratedur = 0.1,
                radius = self.range
            }
        end,
        function () self.range = 3*32
            self.firerate = 0
            self.stats = {
                pos = {self.space[1], self.space[2]},
                mult = 2,
                ratedur = 0.1,
                radius = self.range
            }
        end,
        function () self.range = 4.5*32
            self.firerate = 0
            self.stats = {
                pos = {self.space[1], self.space[2]},
                mult = 2.5,
                ratedur = 0.1,
                radius = self.range
            }
        end   
    }

    self.bspd = 0
    self.dmg = 0
    amp.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.timer = 0
    self.effect = 'weaken'
    self.canshoot = true
    self.cutaudio = false
end

function amp:update(dt, enemies)
    if #enemies ~= 0 then
        for _, e in pairs(enemies) do
            if math.sqrt((self.space[1]-e.x)^2+(self.space[2]-e.y)^2) <= self.range then
                e:takedmg(0, self.effect, self.stats)
            end
        end
    end
    self:playsound()
    local r, g, b = randrgb(109, 79, 75)
    particles:newparticle(self.space[1] + math.random(-3*self.range/4, 3*self.range/4), self.space[2] + math.random(-3*self.range/4, 3*self.range/4),
    math.random()*2, randfloat(0.2, 0.6), -math.pi/2, true, {r, g, b}, 50)
    amp.super.update(self, dt, enemies)
end

function amp:draw(x, y)
    self.dir = 0
    amp.super.draw(self, x, y)
end

return amp