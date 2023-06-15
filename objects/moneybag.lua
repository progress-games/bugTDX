local moneybag = Tower:extend()

function moneybag:new(pos, ground, name)
    self.levels = {
        function ()     
            self.gain = {
            timer = 0,
            count = 0,
            max = 2,
            interval = 0
        } end,
        function ()     
            self.gain = {
            timer = 0,
            count = 0,
            max = 4,
            interval = 0
        } end,
        function ()     
            self.gain = {
            timer = 0,
            count = 0,
            max = 6,
            interval = 0
        } end,
    }

    self.range = 0
    self.dmg = 0
    moneybag.super.new(self, pos, ground, name)
    self.bullet = sprites.arrow
    self.timer = 0
    self.mcount = 0
    self.canshoot = false
end

function moneybag:update(dt)
    if #enemies > 0 then
        self.gain.timer = self.gain.timer + dt
        if self.gain.timer >= self.gain.interval and self.gain.count < self.gain.max then
            money = money + 1
            self.gain.count = self.gain.count + 1
            self.gain.timer = 0
            self:playsound()
            for _=1, 9 do
                particles:newparticle(self.space[1] + 16,
                            self.space[2] + 16, randfloat(1, 1.5), 
                            randfloat(0.1, 0.5), randfloat(0, 2*math.pi), false, {1, 1, 1}, 100, sprites.coin)
            end
        end
    else self.gain.count = 0 end

    if self.vxp.vis then
        self.vxp.timer = self.vxp.timer - dt
        if self.vxp.timer <= 0 then
            self.vxp.vis = false
        end
    end
end

return moneybag