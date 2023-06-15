local fridge = Tower:extend()

function fridge:new(pos, ground, name)
    self.levels = {
        function () self.range = 1.5*32
            self.dmg = 0
            self.firerate = 4
            self.bspd = todt(4)
            self.stats = {
                ratedur = 0.1,
                slow = todt(0.15)
            }
        end,
        function () self.range = 3*32
            self.dmg = 0
            self.firerate = 3
            self.bspd = todt(4)
            self.stats = {
                ratedur = 0.1,
                slow = todt(0.25)
            }
        end,
        function () self.range = 4*32
            self.dmg = 0
            self.firerate = 2
            self.bspd = todt(4)
            self.stats = {
                ratedur = 0.1,
                slow = todt(0.45)
            }
        end,  
    }

    fridge.super.new(self, pos, ground, name)
    self.bullet = sprites.flame
    self.timer = 0
    self.shootingdur = 2
    self.shootingtimer = self.shootingdur
    self.shooting = false
    self.canshoot = true
    self.effect = 'slow'
end

function fridge:update(dt, enemies)
    if self.shooting then
        self.shootingtimer = self.shootingtimer - dt
        self:shoot()
        self.sprite = sprites.fridgeopen
        if self.shootingtimer <= 0 then
            self.shooting = false
            self.sprite = sprites.fridge
        end
    else
        self.shootingtimer = self.shootingtimer + dt
        if self.shootingtimer >= self.firerate then
            self.shootingtimer = self.shootingdur
            self:playsound()
            self.shooting = true
        end
    end

    if self.vxp.vis then
        self.vxp.timer = self.vxp.timer - dt
        if self.vxp.timer <= 0 then
            self.vxp.vis = false
        end
    end
end

function fridge:draw(x, y)
    self.dir = 0
    fridge.super.draw(self, x, y)
end

function fridge:shoot()
    particles:newparticle(self.space[1]+math.random(-3*self.range/4, 3*self.range/4), self.space[2]+math.random(-3*self.range/4, 3*self.range/4), randfloat(0.5, 2), 
    randfloat(0.1, 0.5), self.dir - math.pi/2, false, {(173+math.random(-10, 10))/255, (216+math.random(-10, 10))/255, (230+math.random(-10, 10))/255}, 80)
    
    if #enemies ~= 0 then
        for _, e in pairs(enemies) do
            if math.sqrt((self.space[1]-e.x)^2+(self.space[2]-e.y)^2) <= self.range then
                e:takedmg(0, self.effect, self.stats)
            end
        end
    end
    
    --table.insert(bullets, Bullet(self.space[1], self.space[2], self.dir - math.pi/2, self.bullet, self.dmg, 0, self.range/8, true, false, self.unit, self.effect, self.stats))
end


return fridge