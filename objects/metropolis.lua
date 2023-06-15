local metropolis = Tower:extend()

function metropolis:new(pos, ground, name)
    self.levels = {
        function () self.range = 4*32
            self.dmg = 1.5
            self.basedmg = 1.5
            self.firerate = 1
            self.bspd = todt(7)
            self.towermult = 1 end,
        function () self.range = 4*32
            self.dmg = 1.5
            self.basedmg = 2.5
            self.firerate = 0.9
            self.bspd = todt(7)
            self.towermult = 2 end,
        function () self.range = 4*32
            self.dmg = 1.5
            self.basedmg = 3.5
            self.firerate = 0.7
            self.bspd = todt(7)
            self.towermult = 4 end,    
    }

    metropolis.super.new(self, pos, ground, name)
    self.bullet = sprites.brick
    self.timer = 0
    self.canshoot = true
end

function metropolis:update(dt, enemies)
    local t = metropolis.super.update(self, dt, enemies)

    if #(enemies or {}) == 0 then
        local adj = 0
        local ops = {-1, 0, 1}
        for i=1, #ops do
            for k=1, #ops do
                if ops[i] > 0 and ops[i] <= #board and ops[k] > 0 and ops[k] < #board[1] then
                    if board[self.pos[1]+ops[i]][self.pos[2]+ops[k]].name then
                        adj = adj + 1
                    end
                end
            end
        end
        if adj - 1 == 8 and self.lvl == 3 then
            steam.userStats.setAchievement('COLONISATION')
            steam.userStats.storeStats()
        end
        self.dmg = self.basedmg + (adj-1)*self.towermult
    end

    return t
end

function metropolis:draw(x, y)
    self.dir = 0
    metropolis.super.draw(self, x, y)
end

return metropolis