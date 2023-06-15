local railgun = Tower:extend()

function railgun:new(pos, ground, name)
    self.levels = {
        function () self.range = 4*32
            self.dmg = 1.5
            self.firerate = 1.6
            self.lockedfirerate = self.firerate
            self.minfirerate = 0.2
            self.bspd = todt(7) end,
        function () self.range = 4*32
            self.dmg = 1.5
            self.firerate = 1.4
            self.lockedfirerate = self.firerate
            self.minfirerate = 0.1
            self.bspd = todt(7) end,
        function () self.range = 4*32
            self.dmg = 1.5
            self.firerate = 1
            self.lockedfirerate = self.firerate
            self.minfirerate = 0.05
            self.bspd = todt(7) end, 
    }

    railgun.super.new(self, pos, ground, name)
    self.bullet = sprites.railgunb
    self.timer = 0
    self.canshoot = true
end

function railgun:draw(x, y)
    if x > self.space[1] - 16 and x < self.space[1] + 16 and y > self.space[2] - 16 and y < self.space[2] + 16 then
        love.graphics.circle('line', self.space[1], self.space[2], self.range)
        languages.update_font('desc')
        love.graphics.print(({'I', 'II', 'III'})[self.lvl], self.space[1]-8, self.space[2]-32)
        if self.lvl == 3 then
            love.graphics.print('max xp', self.space[1]-12, self.space[2]+18)
        elseif self.lvl == 2 then
            love.graphics.print(self.xp..'/5 xp', self.space[1]-12, self.space[2]+18)
        elseif self.lvl == 1 then
            love.graphics.print(self.xp..'/3 xp', self.space[1]-12, self.space[2]+18)
        end
    end
    if #(enemies or {}) == 0 then 
        if self.firerate ~= self.lockedfirerate then
            for _=1, 30 do
                local g = randfloat(0.3, 0.6)
                particles:newparticle(self.space[1]+math.random(-4, 4), self.space[2], randfloat(3, 10), randfloat(0.3, 0.6), -math.pi/2, false, {g, g, g}, 100)
            end
        end
        self.firerate = self.lockedfirerate
    end
    local heat = (1-self.firerate)/(1-self.minfirerate)/2
    love.graphics.setColor(1, 1-heat, 1-heat)
    love.graphics.draw(self.sprite, centre.x+32*(self.pos[1]-9)+16, centre.y+32*(self.pos[2]-5)+16, self.dir, 1, 1, 16, 16)
    if self.vxp.vis then
        languages.update_font('desc')
        if self.lvl == 3 then
            love.graphics.print('max xp', self.space[1]-12, self.space[2]+18)
        elseif self.lvl == 2 then
            love.graphics.print(self.xp..'/5 xp', self.space[1]-12, self.space[2]+18)
        elseif self.lvl == 1 then
            love.graphics.print(self.xp..'/3 xp', self.space[1]-12, self.space[2]+18)
        end
    end
    love.graphics.setColor(1, 1, 1)
end

function railgun:shoot()
    if self.firerate > self.minfirerate then
        self.firerate = 11*self.firerate/12
    end
    return railgun.super.shoot(self)
end

return railgun