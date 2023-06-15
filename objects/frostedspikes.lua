local spikes = Tower:extend()

function spikes:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.dmg = 3
            self.firerate = 1.5
            self.bspd = 0
            self.stats = {
                ratedur = 1
            }
        end,
        function () self.range = 3*32
            self.dmg = 4
            self.firerate = 1.4
            self.bspd = 0
            self.stats = {
                ratedur = 1.2
            }
        end,
        function () self.range = 4.5*32
            self.dmg = 5
            self.firerate = 1.2
            self.bspd = 0
            self.stats = {
                ratedur = 1.7
            }
        end,    
    }

    spikes.super.new(self, pos, ground, name)
    self.bullet = sprites.frostedspike

    self.timer = 0
    self.canshoot = true
    self.effect = 'freeze'
end

function spikes:draw(x, y)
    self.dir = 0
    spikes.super.draw(self, x, y)
end


function spikes:shoot()
    if #enemies ~= 0 then
        local pos = ({{-1, 0, 1}, {-2, -1, 0, 1, 2}, {-3, -2, -1, 0, 1, 2, 3}})[self.lvl]
        local around = {-6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6}
        local opps = {}

        for i=1, #pos do
            for k=1, #pos do
                if i ~= 0 and k ~= 0 and self.pos[1] + pos[i] >= 1 and self.pos[1] + pos[i] <= #board
                and self.pos[2] + pos[k] >= 1 and self.pos[2] + pos[k] <= #board[1] then
                    if board[self.pos[1]+pos[i]][self.pos[2]+pos[k]].ground == sprites.path then
                        table.insert(opps, {self.space[1]+pos[i]*32, self.space[2]+pos[k]*32})
                    end
                end
            end
        end

        if #opps > 0 then
            local point = {}
            while true do
                local valid = true
                point = {self.space[1] + math.random(-self.range, self.range), self.space[2] + math.random(-self.range, self.range)}
                local px, py = round((point[1] - (centre.x - 8*32))/32-0.5)+1, round((point[2] - (centre.y - 4*32))/32-0.5)+1
                if px > 0 and px < #board and py > 0 and py < #board[1] then
                    if board[px][py].ground == sprites.path then
                        for i=1, #around do
                            for k=1, #around do
                                local ppx, ppy =  round(((point[1]+around[i]) - (centre.x - 8*32))/32-0.5)+1, round(((point[2]+around[k]) - (centre.y - 4*32))/32-0.5)+1
                                if ppx > 0 and ppx < #board and ppy > 0 and ppy < #board[1] then
                                    if board[ppx][ppy].ground ~= sprites.path then valid = false end
                                end
                            end
                        end
                        if valid then break end
                    end
                else valid = false end
            end
            self:playsound()
            return Bullet(point[1], point[2], -math.pi/2, self.bullet, self.dmg, self.bspd, 1, true, false, self.unit, self.effect, self.stats)
        else return nil end
    else return nil end
end

return spikes