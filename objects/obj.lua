local obj = {}
obj.__index = obj

function obj:update(dt)

end

function obj:draw()

end

local function new()
    return setmetatable({

    }, obj)
end

return setmetatable({new = new}, {__call = function(_, ...) return new(...) end})