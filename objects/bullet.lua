local bullet = {}
bullet.__index = bullet

function bullet:update(dt)
    if self.x > world.x + 100 or self.x < -100 or self.y > world.y + 100 or self.y < -100 or (self.sprite == sprites.spike and #enemies == 0) then
        return true
    else
        if self.sprite == sprites.rocket then
            for _=1, 3 do
                local g = randfloat(0, 0.2)
                particles:newparticle(self.x - 5*math.cos(self.dir), self.y - 5*math.sin(self.dir), randfloat(1, 4), 
                randfloat(0.1, 0.5), self.dir  - math.pi + torad(math.random(-20, 20)), false, {randfloat(0.7, 1)+g, g, 0}, 10)
            end
        end

        self.x = self.x + self.spd*math.cos(self.dir)*dt
        self.y = self.y + self.spd*math.sin(self.dir)*dt
    end
    if self.spin then self.r = self.r + 0.1 end

    if self.stats.range then 
        self.stats.range = self.stats.range - self.spd*dt
        if self.stats.range <= 0 then return true end
    end

    if self.stats.dur then
        self.stats.dur = self.stats.dur - dt
        if self.stats.dur <= 0 then return true end
    end

    if self.effect == 'sniper' then
        if #enemies >= self.stats.target then
            local tar = enemies[self.stats.target]
            if math.sqrt((self.x-self.stats.x)^2+(self.y-self.stats.y)^2) > self.stats.distance then
                tar:takedmg(self.dmg)
                return true
            end
        end
    end
end

function bullet:draw(fout)
    if self.sprite ~= sprites.flame then
        love.graphics.draw(self.sprite, self.x, self.y, self.dir+math.pi/2 + self.r, self.scale, self.scale, 8, 8)
    end
end

local function new(x, y, direction, sprite, damage, speed, scale, player, spin, unit, effect, stats)
    return setmetatable({
        x = x,
        y = y,
        dir = direction,
        sprite = sprite,
        dmg = damage,
        spd = speed,
        scale = scale,
        player = player,
        spin = spin,
        r = tobin(spin)*randfloat(0, math.pi*2),
        unit = unit,
        effect = effect,
        stats = table.copy(stats)
    }, bullet)
end

return setmetatable({new = new}, {__call = function(_, ...) return new(...) end})