local font = {}
font.__index = font

function font:newtype(name, size, fill, outline, rotation, fcolour, ocolour, spacing)
    if size == 0 then size = 0.01 end
    self.types[name] = {
        colours = {
            outline = ocolour or {1, 1, 1},
            fill = fcolour or {1, 1, 1}},
        size = size or 1,
        outline = outline or false,
        fill = fill or false,
        rotation = rotation or 0,
        spacing = spacing or 55*size
    }
end

function font:update(dt)

end

function font:scaletype(name, size)
    local ratio = (self.types[name].size - size)/(self.types[name].size)
    self.types[name].spacing = self.types[name].spacing + self.types[name].spacing*(1-ratio)
    self.types[name].size = self.types[name].size + size
end

function font:draw(text, name, x, y)
    local set, colours = self.types[name], self.types[name].colours

    if set.fill then
        love.graphics.setColor(colours.fill[1], colours.fill[2], colours.fill[3])
        local push = 0
        for i=1, string.len(text) do
            if text:sub(i, i) ~= ' ' then
                love.graphics.draw(self.characters[text:sub(i, i)].img.fill, 
                self.characters[text:sub(i, i)].fill, x+set.spacing*(i-1+push), y, set.rotation, set.size, set.size)
            else push = push - 0.2 end
        end
    end
    
    if set.outline then
        love.graphics.setColor(colours.outline[1], colours.outline[2], colours.outline[3])
        local push = 0
        for i=1, string.len(text) do
            if text:sub(i, i) ~= ' ' then
                love.graphics.draw(self.characters[text:sub(i, i)].img.out, 
                self.characters[text:sub(i, i)].outline, x+set.spacing*(i-1+push), y, set.rotation, set.size, set.size)
            else push = push - 0.2 end
        end
    end
end

local function new(name, dir)
    return setmetatable({
        name = name,
        dir = dir
    }, font)
end

function font:init()
    self.list = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()'
    self.characters = {}
    self.types = {}

    self.lowercase = {
        list = 'abcdefghijklmnopqrstuvwxyz',
        outline = love.graphics.newImage(self.dir..self.name..'_out.png'),
        fill = love.graphics.newImage(self.dir..self.name..'_fill.png')
    }

    self.uppercase = {
        list = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
        outline = love.graphics.newImage(self.dir..self.name..'_up'..'_out.png'),
        fill = love.graphics.newImage(self.dir..self.name..'_up'..'_fill.png')
    }

    self.numbers = {
        list = '1234567890!@#$%^&*()',
        outline = love.graphics.newImage(self.dir..self.name..'_num'..'_out.png'),
        fill = love.graphics.newImage(self.dir..self.name..'_num'..'_fill.png')
    }

    local x, y = 0, 0
    for c in self.lowercase.list:gmatch'.' do
        self.characters[tostring(c)] = {
            outline = love.graphics.newQuad(x*64, y*64, 64, 64, self.lowercase.outline),
            fill =  love.graphics.newQuad(x*64, y*64, 64, 64, self.lowercase.fill),
            img = {
                out = self.lowercase.outline,
                fill = self.lowercase.fill
            }
        }
        
        if x < 5 then 
            x = x + 1
        else
            y = y + 1
            x = 0 
        end
    end

    local x, y = 0, 0
    for c in self.uppercase.list:gmatch'.' do
        self.characters[tostring(c)] = {
            outline = love.graphics.newQuad(x*64, y*64, 64, 64, self.uppercase.outline),
            fill =  love.graphics.newQuad(x*64, y*64, 64, 64, self.uppercase.fill),
            img = {
                out = self.uppercase.outline,
                fill = self.uppercase.fill
            }
        }
        
        if x < 5 then 
            x = x + 1
        else
            y = y + 1
            x = 0 
        end
    end
end

return setmetatable({new = new}, {__call = function(_, ...) return new(...) end})