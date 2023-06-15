local poison = Tower:extend()

function poison:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.dmg = 0.7
            self.firerate = 4
            self.stats = {
                dur = 1.5
            }
            self.bspd = 0 end,
        function () self.range = 3*32
            self.dmg = 1.2
            self.firerate = 3.5
            self.stats = {
                dur = 2
            }
            self.bspd = 0 end,
        function () self.range = 4.5*32
            self.dmg = 2.5
            self.firerate = 2.5
            self.stats = {
                dur = 2.5
            }
            self.bspd = 0 end,    
    }

    poison.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.effect = 'poison'
    self.timer = 0
    self.canshoot = true
end

function poison:draw(x, y)
    self.dir = 0
    poison.super.draw(self, x, y)
end


function poison:shoot()
    local pos = ({{-1, 0, 1}, {-2, -1, 0, 1, 2}, {-3, -2, -1, 0, 1, 2, 3}})[self.lvl]
    local opps = {}

    for i=1, #pos do
        for k=1, #pos do
            if pos[i] ~= 0 and pos[k] ~= 0 and self.pos[1] + pos[i] >= 1 and self.pos[1] + pos[i] <= #board
            and self.pos[2] + pos[k] >= 1 and self.pos[2] + pos[k] <= #board[1] then
                if board[self.pos[1]+pos[i]][self.pos[2]+pos[k]].ground == sprites.path then
                    table.insert(opps, {self.space[1]+pos[i]*32, self.space[2]+pos[k]*32})
                end
            end
        end
    end

    if #opps > 0 then
        local c = math.random(1, #opps)

        for _=1, 30 do
            particles:newparticle(opps[c][1] + math.random(-10, 10), opps[c][2] + math.random(-10, 10), math.random(5, 15), 0, 0, false, {randrgb(115,211,0)}, 80)
        end
        self:playsound()

        return Bullet(opps[c][1], opps[c][2], 0, self.bullet, self.dmg, self.bspd, 1, true, false, self.unit, self.effect, self.stats)
    else return nil end
end

return poison