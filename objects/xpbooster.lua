local xpbooster = Tower:extend()

function xpbooster:new(pos, ground, name)
    self.levels = {
        function () self.range = 0; self.dmg = 0; self.firerate = math.huge; self.bspd = 0 end,
        function () self.range = 0; self.dmg = 0; self.firerate = math.huge; self.bspd = 0 end,
        function () self.range = 0; self.dmg = 0; self.firerate = math.huge; self.bspd = 0 end,    
    }

    xpbooster.super.new(self, pos, ground, name)
    self.bullet = sprites.arrow
    self.timer = math.huge
    self.canshoot = false
end

function xpbooster:placed()
    local ops = {-1, 0, 1}

    for i=1, #ops do
        for k=1, #ops do
            if not (ops[i] == 0 and ops[k] == 0) and self.pos[1]+ops[i] > 0 and self.pos[1]+ops[i] < #board and
            self.pos[2]+ops[k] > 0 and self.pos[2]+ops[k] < #board[1] then
                if board[self.pos[1]+ops[i]][self.pos[2]+ops[k]].name and 
                board[self.pos[1]+ops[i]][self.pos[2]+ops[k]].merge ~= nil then
                    board[self.pos[1]+ops[i]][self.pos[2]+ops[k]]:merge()
                end
            end
        end
    end
end

function xpbooster:merge()
    xpbooster.super.merge(self)
    self:placed()
end

function xpbooster:draw(x, y)
    self.dir = 0
    xpbooster.super.draw(self, x, y)
end

return xpbooster