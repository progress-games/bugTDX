local campfire = Tower:extend()

function campfire:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.firerate = 0
            self.stats = {
                pos = {self.space[1], self.space[2]},
                mult = 2,
                dur = 0.1,
                radius = self.range
            }
        end,
        function () self.range = 3*32
            self.firerate = 0
            self.stats = {
                pos = {self.space[1], self.space[2]},
                mult = 4,
                dur = 0.1,
                radius = self.range
            }
        end,
        function () self.range = 4.5*32
            self.firerate = 0
            self.stats = {
                pos = {self.space[1], self.space[2]},
                mult = 6,
                dur = 0.1,
                radius = self.range
            }
        end   
    }

    self.bspd = 0
    self.dmg = 0
    campfire.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.timer = 0
    self.effect = 'burn mult'
    self.canshoot = true
    self.cutaudio = false
end

function campfire:update(dt, enemies)
    local g = randfloat(0, 0.2)
    particles:newparticle(self.space[1] + math.random(-3*self.range/4, 3*self.range/4), self.space[2] + math.random(-3*self.range/4, 3*self.range/4),
    math.random()*2, randfloat(0.2, 0.6), -math.pi/2, true, {randfloat(0.7, 1)+g, g, 0}, 50)
    self:playsound()
    if #enemies ~= 0 then
        for _, e in pairs(enemies) do
            if math.sqrt((self.space[1]-e.x)^2+(self.space[2]-e.y)^2) <= self.range then
                e:takedmg(0, self.effect, self.stats)
            end
        end
    end
    campfire.super.update(self, dt, enemies)
end

function campfire:draw(x, y)
    self.dir = 0
    campfire.super.draw(self, x, y)
end

return campfire