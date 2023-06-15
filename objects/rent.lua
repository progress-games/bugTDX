local rent = Tower:extend()

function rent:new(pos, ground, name)
    self.levels = {
        function () self.range = 0
            self.dmg = 0
            self.firerate = math.huge
            self.bspd = 0
            self.fee = 2
            self.spaces = 1 end,
        function () self.range = 0
            self.dmg = 0
            self.firerate = math.huge
            self.bspd = 0
            self.fee = 2
            self.spaces = 2 end,
        function () self.range = 0
            self.dmg = 0
            self.firerate = math.huge
            self.bspd = 0
            self.fee = 3
            self.spaces = 3 end, 
    }

    rent.super.new(self, pos, ground, name)
    self.bullet = sprites.arrow
    self.timer = math.huge
    self.canshoot = false
end

function rent:placed()
    maxtowers = maxtowers + self.spaces
end

function rent:merge()
    local l = self.lvl
    rent.super.merge(self)
    if l ~= self.lvl then
        maxtowers = maxtowers + 1
    end
end

function rent:update(dt, enemies)
    if self.vxp.vis then
        self.vxp.timer = self.vxp.timer - dt
        if self.vxp.timer <= 0 then
            self.vxp.vis = false
        end
    end
end

return rent