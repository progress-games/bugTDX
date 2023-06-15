local ritual = Tower:extend()

function ritual:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.dmg = 1
            self.firerate = 4
            self.bspd = 0 
            self.stats = {
                dur = 2.5
            }
        end,
        function () self.range = 2.5*32
            self.dmg = 2
            self.firerate = 3
            self.bspd = 0 
            self.stats = {
                dur = 3.5
            } end,
        function () self.range = 3.5*32
            self.dmg = 4
            self.firerate = 2
            self.bspd = 0 
            self.stats = {
                dur = 5
            } end,    
    }

    ritual.super.new(self, pos, ground, name)
    self.bullet = sprites.flame

    self.timer = 0
    self.rdir = 0
    self.canshoot = true
    self.effect = 'teleport'
end

function ritual:draw(x, y)
    self.dir = 0
    self.rdir = self.rdir + 0.01
    self.dir = self.rdir
    ritual.super.draw(self, x, y)
end


function ritual:shoot()
    local pos = ({{-1, 0, 1}, {-2, -1, 0, 1, 2}, {-3, -2, -1, 0, 1, 2, 3}})[self.lvl]
    local opps = {}

    for i=1, #pos do
        for k=1, #pos do
            if pos[i] ~= 0 and pos[k] ~= 0 and self.pos[1] + pos[i] >= 1 and self.pos[1] + pos[i] <= #board
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
            --brown (159+math.random(-10, 10))/255,(89+math.random(-10, 10))/255,(39+math.random(-10, 10))/255
            --purple (130+math.random(-10, 10))/255,(109+math.random(-10, 10))/255,(140+math.random(-10, 10))/255
            particles:newparticle(opps[c][1] + math.random(-10, 10), opps[c][2] + math.random(-10, 10), math.random(5, 15), 0, 0, false, {(130+math.random(-10, 10))/255,(109+math.random(-10, 10))/255,(140+math.random(-10, 10))/255}, 80*(self.stats.dur/5))
        end
        self:playsound()
        return Bullet(opps[c][1], opps[c][2] + 5, math.pi/2, self.bullet, self.dmg, self.bspd, 1, true, false, self.unit, self.effect, self.stats)
    else return nil end
end

return ritual