local overload = Tower:extend()

function overload:new(pos, ground, name)
    self.levels = {
        function ()
            self.boost = {
                firerate = 0.6,
                dmg = 1.5
            }
            self.range = 1.5*32
            self.connections = 1 end,
        function ()
            self.boost = {
                firerate = 0.4,
                dmg = 2
            }
            self.range = 2.5*32
            self.connections = 2 end,
        function ()
            self.boost = {
                firerate = 0.2,
                dmg = 2.5
            }
            self.range = 3.5*32
            self.connections = 4 end,
    }

    overload.super.new(self, pos, ground, name)

    self.boosting = {}
end

function overload:update(dt)
    for _, v in pairs(self.boosting) do
        if math.random(1, 3) == 3 then
            particles:newparticle(v.pos[1]*32+centre.x-8*32-4, v.pos[2]*32+centre.y-4*32-4, randfloat(0.4, 1.2), randfloat(0.1, 0.5), -math.pi/2, false, {1, 1, 1}, 50, sprites.lightning)
        end
    end

    if self.vxp.vis then
        self.vxp.timer = self.vxp.timer - dt
        if self.vxp.timer <= 0 then
            self.vxp.vis = false
        end
    end
end

function overload:endbuy()
    local pos = ({{-1, 0, 1}, {-2, -1, 0, 1, 2}, {-3, -2, -1, 0, 1, 2, 3}})[self.lvl]
    local opps = {}

    for i=1, #pos do
        for k=1, #pos do
            if not (pos[i] == 0 and pos[k] == 0) and self.pos[1] + pos[i] >= 1 and self.pos[1] + pos[i] <= #board
            and self.pos[2] + pos[k] >= 1 and self.pos[2] + pos[k] <= #board[1] then
                if board[self.pos[1]+pos[i]][self.pos[2]+pos[k]].obj then
                    table.insert(opps, {self.pos[1]+pos[i], self.pos[2]+pos[k]})
                end
            end
        end
    end

    if #opps > 0 then
        local s = self.connections
        if #opps < self.connections then self.connections = s end
        for i=1, s do
            local t = opps[math.random(1, #opps)]
            if names[board[t[1]][t[2]].name].var == 'attack' then
                --love.event.quit()
                table.insert(self.boosting, {
                    pos = {t[1], t[2]},
                    firerate = board[t[1]][t[2]].firerate,
                    dmg = board[t[1]][t[2]].dmg
                })
                board[t[1]][t[2]].firerate = board[t[1]][t[2]].firerate*self.boost.firerate
                board[t[1]][t[2]].dmg = board[t[1]][t[2]].dmg*self.boost.dmg
            end
        end
        self:playsound()
    end
end

function overload:endwave()
    for _, v in pairs(self.boosting) do
        board[v.pos[1]][v.pos[2]].dmg = v.dmg
        board[v.pos[1]][v.pos[2]].firerate = v.firerate
    end
    self.boosting = {}
end

return overload