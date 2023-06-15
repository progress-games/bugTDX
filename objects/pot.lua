local pot = Tower:extend()

function pot:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.stats = {
                dmg = 0.2,
                rate = 1,
                ratetimer = 0.2,
                slow = todt(0.05),
                range = 48,
                dur = 3,
                ratedur = 4
            }
            self.dmg = 0.02
            self.firerate = 4
            self.bspd = 0 end,
        function () self.range = 3*32
            self.stats = {
                dmg = 0.8,
                rate = 1,
                ratetimer = 0.2,
                slow = todt(0.1),
                range = 3*32,
                dur = 3,
                ratedur = 6
            }
            self.dmg = 0.1
            self.firerate = 3.5
            self.bspd = 0 end,
        function () self.range = 4.5*32
            self.stats = {
                dmg = 1.7,
                rate = 1,
                ratetimer = 0.2,
                slow = todt(0.2),
                range = 4.5*32,
                dur = 4,
                ratedur = 9
            }
            self.dmg = 0.3
            self.firerate = 2.5
            self.bspd = 0 end,    
    }

    pot.super.new(self, pos, ground, name)
    self.bullet = sprites.flame

    self.timer = 0
    self.canshoot = true
    self.effect = 'oil'
end

function pot:draw(x, y)
    self.dir = 0
    pot.super.draw(self, x, y)
end


function pot:shoot()
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
            --brown (159+math.random(-10, 10))/255,(89+math.random(-10, 10))/255,(39+math.random(-10, 10))/255
            --blue 0.05, 0.05, randfloat(0, 0.1)
            --green (77+math.random(-10, 10))/255,107+math.random(-10, 10))/255,83+math.random(-10, 10))/255)
            --blue/grey (102+math.random(-10, 10))/255, (153+math.random(-10, 10))/255, (204+math.random(-10, 10))/255
            --ddark blue/grey (41+math.random(-10, 10))/255, (70+math.random(-10, 10))/255, (91+math.random(-10, 10))/255
            particles:newparticle(opps[c][1] + math.random(-10, 10), opps[c][2] + math.random(-10, 10), math.random(5, 15), 0, 0, false, {(41+math.random(-10, 10))/255, (70+math.random(-10, 10))/255, (91+math.random(-10, 10))/255}, 80)
        end
        self:playsound()
        return Bullet(opps[c][1], opps[c][2], 0, self.bullet, self.dmg, self.bspd, 1, true, false, self.unit, self.effect, self.stats)
    else return nil end
end

return pot