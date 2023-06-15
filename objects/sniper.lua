local sniper = Tower:extend()

function sniper:new(pos, ground, name)
    self.levels = {
        function () self.range = math.huge; self.dmg = 8; self.firerate = 3; self.bspd = todt(15) end,
        function () self.range = math.huge; self.dmg = 12; self.firerate = 2.5; self.bspd = todt(18) end,
        function () self.range = math.huge; self.dmg = 16; self.firerate = 1.5; self.bspd = todt(20) end,    
    }

    sniper.super.new(self, pos, ground, name)
    self.bullet = sprites.sniperb
    self.timer = 0
    self.target = 0
    self.effect = 'sniper'
    self.stats = {target = 0, distance = 0, x = self.space[1], y = self.space[2]}
    self.canshoot = true
end

function sniper:update(dt, enemies)
    if enemies and #(enemies or {}) > 0 then
        if self.target == 0 or self.target > #enemies then
            self.target = math.random(1, #enemies)
            self.stats.target = self.target
            self.stats.distance = math.sqrt((enemies[self.target].x-self.space[1])^2+(enemies[self.target].y-self.space[2])^2)
        end

        self.dir = math.atan2(self.space[2] - enemies[self.target].y, self.space[1] - enemies[self.target].x) + 3*math.pi/2

        if self.canshoot then
            self.timer = self.timer + dt
            if self.timer >= self.firerate then
                self.timer = 0
                return 'shoot'
            end
        end
    else
        self.target = 0
    end

    if self.vxp.vis then
        self.vxp.timer = self.vxp.timer - dt
        if self.vxp.timer <= 0 then
            self.vxp.vis = false
        end
    end
end

function sniper:draw(x, y)
    if #(enemies or {}) ~= 0 then
        love.graphics.setColor(1, 0, 0, 0.5)
        love.graphics.line(self.space[1], self.space[2], enemies[self.target].x, enemies[self.target].y)
        love.graphics.setColor(1, 1, 1)
    end
    sniper.super.draw(self, x, y)
end

return sniper