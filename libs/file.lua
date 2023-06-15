local file = {}

function file.exists(name)
    local info = love.filesystem.getInfo(name)
    return info ~= nil and info.type == 'file'
end

function file.read(name)
    local lines = {}
    local contents, size = love.filesystem.read(name)
    for line in string.gmatch(contents, "[^\r\n]+") do
        table.insert(lines, line)
    end
    return lines
end

function file.write(name, lines)
    s = love.filesystem.remove(name)
    
    f = love.filesystem.newFile(name)
    f:open('w')

    for _, line in ipairs(lines) do
        print(line)
        f:write(line..',')
    end

    f:close()
end

return file