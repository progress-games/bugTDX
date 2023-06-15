local shapeshifter = Tower:extend()

function shapeshifter:new(pos, ground, name)
    self.levels = {
        function () self.range = 0; self.dmg = 0; self.firerate = 0; self.bspd = 0 end,
        function () self.range = 0; self.dmg = 0; self.firerate = 0; self.bspd = 0 end,
        function () self.range = 0; self.dmg = 0; self.firerate = 0; self.bspd = 0 end,   
    }

    shapeshifter.super.new(self, pos, ground, name)
    self.bullet = sprites.arrow
    self.timer = 0
    self.canshoot = true
    self.tower = nil
end

function shapeshifter:endbuy()
    local n = {}
    for i, v in pairs(names) do
        if v.var == 'attack' and i ~= self.name then table.insert(n, i) end
    end
    local t = n[math.random(1, #n)]
    self.tower = _G[capitalise(t)](self.pos, self.ground, t, 3)
    self.tower.lvl = self.lvl
    self.tower:updatedesc()
    self:playsound()
end

function shapeshifter:update(dt, enemies)
    if #enemies ~= 0 then
        if type(self.tower.update) == 'function' then
            local b = self.tower:update(dt, enemies)
            if b == 'shoot' then
                table.insert(bullets, self.tower:shoot()) 
            end
        end
    end

    if self.vxp.vis then
        self.vxp.timer = self.vxp.timer - dt
        if self.vxp.timer <= 0 then
            self.vxp.vis = false
        end
    end
end

function shapeshifter:draw(x, y)
    if #enemies ~= 0 then
        self.tower:draw(x, y)
    else shapeshifter.super.draw(self, x, y) end
end

return shapeshifter