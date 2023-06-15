local languages = {}

function languages.load()
    local raw_data = file.read('translations.csv')
    local headers = split(raw_data[1], ',')
    local cleaned = {}

    for i, row in pairs(raw_data) do
        if i ~= 1 then
            local items = split(row, ',')

            cleaned[items[1]] = {['english'] = items[1]}

            for word, lang in pairs(headers) do
                cleaned[items[1]][lang] = items[word]
            end
        end
    end

    return cleaned
end

function languages.get_languages()
    local raw_data = file.read('translations.csv')
    return split(raw_data[1], ',')
end

function languages.printf(text, x, y, limit, align, sep)
    local lang = config['language']
    local offcut = ''
    if sep == nil then sep = '' end

    if type(text) == 'table' then
        text, offcut = unpack(text)
        if intable(translations, offcut) then
            offcut = translations[offcut][lang]
        end
        if offcut == nil then offcut = '' end
        offcut = ' '..offcut
    end
    
    if intable(translations, text) then
        text = translations[text][lang]
    end

    if lang ~= 'english' then y = y - 10 end

    local text_font = love.graphics.getFont()

    love.graphics.printf(text..sep..offcut, x, y, limit, align)
end

function languages.print(text, x, y, sep)
    local lang = config['language']
    local offcut = ''
    if sep == nil then sep = '' end

    if type(text) == 'table' then
        text, offcut = unpack(text)
        if intable(translations, offcut) then
            offcut = translations[offcut][lang]
        end
        offcut = ' '..tostring(offcut)
    end
    
    if intable(translations, text) then
        text = translations[text][lang]
    end


    if lang ~= 'english' then  y = y - 10 end

    love.graphics.print(text..sep..offcut, x, y)
end

function languages.outline(text, x, y, ol)
    local lang = config['language']
    local offcut = ''

    if type(text) == 'table' then
        text, offcut = unpack(text)
        if intable(translations, offcut) then
            offcut = translations[offcut][lang]
        end
        offcut = ' '..tostring(offcut)
    end
    
    if intable(translations, text) then
        text = translations[text][lang]
    end

    local font = love.graphics.getFont()
    local textObj = love.graphics.newText(font, text..offcut) -- Can be optimized if you define it once then you redefine it with :set(text)

    love.graphics.setColor(0, 0, 0)

    local n = -ol
    for i=1,2 do
        love.graphics.draw(textObj, x, y+n)
        love.graphics.draw(textObj, x+n, y)
        love.graphics.draw(textObj, x-n, y+n)
        love.graphics.draw(textObj, x+n, y-n)
        n = -n
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(textObj, x, y)

    textObj:release()
end

function languages.outlinef(text, x, y, limit, ol)
    local lang = config['language']
    local offcut = ''

    if type(text) == 'table' then
        text, offcut = unpack(text)
        if intable(translations, offcut) then
            offcut = translations[offcut][lang]
        end
        offcut = ' '..tostring(offcut)
    end
    
    if intable(translations, text) then
        text = translations[text][lang]
    end

    text = text..offcut

    local f = love.graphics.getFont()
    local w, len = f:getWrap(text, limit)
    local h = f:getHeight()

    for k, v in pairs(len) do
        local x = (2*x+limit)/2 - f:getWidth(v)/2
        local y = y + (k-1)*h

        local textObj = love.graphics.newText(f, text..offcut)

        love.graphics.setColor(0, 0, 0)

        local n = -ol
        for i=1,2 do
            love.graphics.draw(textObj, x, y+n)
            love.graphics.draw(textObj, x+n, y)
            love.graphics.draw(textObj, x-n, y+n)
            love.graphics.draw(textObj, x+n, y-n)
            n = -n
        end

        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(textObj, x, y)

        textObj:release()
    end
end

function languages.update_font(name)
    love.graphics.setFont(font[config['language']][name])
end

return languages