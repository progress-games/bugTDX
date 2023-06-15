local volcano = Tower:extend()

function volcano:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.stats = {
                dmg = 3,
                rate = 0.8,
                ratetimer = 0.2,
                range = 1.5*32,
                ratedur = 4,
                dur = 1.5
            }
            self.dmg = 0.4
            self.firerate = 4
            self.bspd = 0 end,
        function () self.range = 3*32
            self.stats = {
                dmg = 3,
                rate = 0.7,
                ratetimer = 0.2,
                range = 3*32,
                ratedur = 6,
                dur = 2
            }
            self.dmg = 0.6
            self.firerate = 3
            self.bspd = 0 end,
        function () self.range = 4.5*32
            self.stats = {
                dmg = 5,
                rate = 0.5,
                ratetimer = 0.2,
                range = 4.5*32,
                ratedur = 8,
                dur = 4
            }
            self.dmg = 0.8
            self.firerate = 1
            self.bspd = 0 end,    
    }

    volcano.super.new(self, pos, ground, name)
    self.bullet = sprites.oil

    self.timer = 0
    self.canshoot = true
    self.effect = 'lava'
end

function volcano:draw(x, y)
    self.dir = 0
    volcano.super.draw(self, x, y)
end


function volcano:shoot()
    local pos = ({{-1, 0, 1}, {-2, -1, 0, 1, 2}, {-3, -2, -1, 0, 1, 2, 3}})[self.lvl]
    local opps = {}

    for i=1, #pos do
        for k=1, #pos do
            if i ~= 0 and k ~= 0 and self.pos[1] + pos[i] >= 1 and self.pos[1] + pos[i] <= #board
            and self.pos[2] + pos[k] >= 1 and self.pos[2] + pos[k] <= #board then
                if board[self.pos[1]+pos[i]][self.pos[2]+pos[k]].ground == sprites.path then
                    table.insert(opps, {self.space[1]+pos[i]*32, self.space[2]+pos[k]*32})
                end
            end
        end
    end

    if #opps > 0 then
        local c = math.random(1, #opps)

        for _=1, 30 do
            local g = randfloat(0, 0.2)
            particles:newparticle(opps[c][1] + math.random(-10, 10), opps[c][2] + math.random(-10, 10), math.random(5, 15), 0, 0, false, {randfloat(0.7, 1)+g, g, 0}, 80)
        end
        self:playsound()
        return Bullet(opps[c][1], opps[c][2], 0, self.bullet, self.dmg, self.bspd, 1, true, false, self.unit, self.effect, self.stats)
    else return nil end
end

return volcano