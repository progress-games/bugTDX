local particles = {}
particles.__index = particles

function particles:update(dt)
    for i, v in pairs(self.particles) do
        if v.r < 0.1 or v.s < 0.01 and v.s ~= 0 then
            table.remove(self.particles, i)
        else
            v.x = v.x + v.s*dt*math.cos(v.dir)
            v.y = v.y + v.s*dt*math.sin(v.dir)
            v.r = v.r - v.r/v.decay
            v.s = v.s - v.s/v.decay
            v.rotation = v.rotation + v.rotationspeed
        end
    end 
end

function particles:draw(r)
    if r then
        for _, v in pairs(self.particles) do
            if v.r >= 1 then
                love.graphics.setColor(0, 0, 0)
                if v.sprite then
                    love.graphics.draw(v.sprite, v.x, v.y, v.rotation, v.r+0.1, v.r+0.1, 16, 16)
                else
                    love.graphics.circle('fill', v.x, v.y, v.r+2)
                end
            end
        end
    end

    for _, v in pairs(self.particles) do
        if v.fade then
            love.graphics.setColor(v.colour[1], v.colour[2], v.colour[3], v.r/v.mr)
        else 
            love.graphics.setColor(v.colour[1], v.colour[2], v.colour[3])
        end

        if v.sprite then
            love.graphics.draw(v.sprite, v.x, v.y, v.rotation, v.r, v.r, 16, 16)
        else
            love.graphics.circle('fill', v.x, v.y, v.r)
        end
    end

    love.graphics.setColor(1, 1, 1)
end

function particles:newparticle(x, y, size, speed, direction, fade, colour, decay, sprite, rotation, rotationspeed)
    table.insert(self.particles, {
        x = x,
        y = y,
        r = size,
        mr = size,
        s = todt(speed),
        dir = direction,
        fade = fade,
        colour = colour or {1, 1, 1},
        decay = decay or 200,
        sprite = sprite or nil,
        rotation = rotation or 0,
        rotationspeed = rotationspeed or 0
    })
end

function particles:newrectangle(rect, size, speed, fade, colour, decay, sprite, rotation, rotationspeed)
    local edge, x, y = math.random(1, 4), 0, 0
    if edge == 1 then 
        x = math.random(rect.x, rect.x + rect.w)
        y = rect.y
        dir = torad(math.random(180, 360))
    elseif edge == 2 then 
        x = math.random(rect.x, rect.x+rect.w)
        y = rect.y + rect.h
        dir = torad(math.random(0, 180))
    elseif edge == 3 then 
        y = math.random(rect.y, rect.y+rect.h)
        x = rect.x
        dir = torad(math.random(90, 270))
    elseif edge == 4 then
        y = math.random(rect.y, rect.y+rect.h)
        x = rect.x + rect.w 
        dir = torad(math.random(270, 450))
    end
    table.insert(self.particles, {
        x = x,
        y = y,
        r = size,
        mr = size,
        s = todt(speed),
        dir = dir,
        fade = fade,
        colour = colour or {1, 1, 1},
        decay = decay or 200,
        sprite = sprite or nil,
        rotation = rotation or 0,
        rotationspeed = rotationspeed or 0
    })
end

local function new()
    return setmetatable({
        particles = {}
    }, particles)
end

return setmetatable({new = new}, {__call = function(_, ...) return new(...) end})