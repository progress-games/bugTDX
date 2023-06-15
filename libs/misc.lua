--returns if some key is in some table
function intable(set, key)
    return set[key] ~= nil
end

--returns a copy of a given table that recursively copies each table/subtable
function table.copy(t)
    local t2 = {};
    for k,v in pairs(t) do
      if type(v) == "table" then
          t2[k] = table.copy(v);
      else
          t2[k] = v;
      end
    end
    return t2;
end

function zoom(t, start, pause, pausedur, goal, dur)
    local half = dur/2

    if t > half - pausedur/2 and t < half + pausedur/2 then
        return pause
    end

    if t > 0 and t < half - pausedur/2 then
        local progress = t/(half - pausedur/2)
        local difference = math.abs(start - pause)
        if start >= pause then
            return start - progress*difference
        else
            return start + progress*difference
        end
    end

    if t > half + pausedur/2 and t <= dur then
        local progress = (t-(half+pausedur/2))/(half - pausedur/2)
        local difference = math.abs(pause - goal)
        if pause >= goal then
            return pause - progress*difference
        else
            return pause + progress*difference
        end
    end

    return goal
end

--breaks up a string based off a limit or delimeter
function split(str, sep, limit)
    local t, cur = {}, ''
    local len = #sep
    for c in str:gmatch'.' do
        if c ~= sep and #(cur..c) < (limit or math.huge) and not string.find(cur, sep) then 
            cur = cur..c 
        else
            cur = string.gsub(cur, sep, '')
            table.insert(t, cur)
            if len < 2 then cur = '' 
            else cur = c end
        end
    end
    table.insert(t, cur)
    return t
end

function inrange(m, n, r)
    return m-r < n and m+r > n
end

function max_len(t)
    local len = 0
    for _, v in pairs(t) do
        if #v > len then len = #v end
    end
    return len
end

function boolify(str)
    if str == 'false' then return false
    elseif str == 'true' then return true
    else return str end
end

--draws a textbox around text using printf
function textbox(text, x, y, limit)
    if type(text) == 'table' then
        text, other = unpack(text)
    else other = '' end

    if intable(translations, text) then
        text = translations[text][config['language']]
    end

    text = text..other

    local center = (2*x + limit)/2
    local font = love.graphics.getFont()
    local width, split_text = font:getWrap(text, limit)
    --if type(split_text) ~= 'table' then split_text = {'a'} end
    local height = #split_text * font:getHeight()

    return {x = center-width/2-5, y = y-5, w = width+10, h = height+10}
end

--reverses a table
function reverse(t)
    local r = {}
    for i=#t, 1, -1 do
        table.insert(r, t[i])
    end
    return r
end    

--draws a textbox around text using print (textboxBasic)
function textboxB(text, x, y)
    if type(text) == 'table' then
        text, other = unpack(text)
    else other = '' end

    if intable(translations, text) then
        text = translations[text][config['language']]
    end

    text = text..other

    local font = love.graphics.getFont()
    local width = font:getWidth(text)
    local height = font:getHeight()
    return {x = x-5, y=y-5, w = width+10, h = height + 10}
end

function get_value(t, v)
    vs = {}
    for _, tb in pairs(t) do
        table.insert(vs, tb[v])
    end
    return vs
end

function merge_boxes(boxes)
    local x = math.min(unpack(get_value(boxes, 'x')))
    local y = math.min(unpack(get_value(boxes, 'y')))

    local w, h = 0, 0
    for _, box in pairs(boxes) do
        w = math.max(w, box.x+box.w)
        h = math.max(h, box.y+box.h)
    end

    w = w - x
    h = h - y
    
    return {x=x, y=y, w=w, h=h}
end


--returns a randomfloat in range m, n
function randfloat(m, n)
    if m == n then return m
    else return math.random()+math.random(m, n-1) end
end

function isnum(s)
    return tonumber(s) ~= nil
end

---returns a random rgb number taking rgb and returning rgb%
function randrgb(r, g, b, v)
    if v == nil then v = 20 end
    return (r+math.random(-v, v))/255, (g+math.random(-v, v))/255, (b+math.random(-v, v))/255
end

--uses math.min but returns nil if neither a nor b exist
function min(a, b)
    if not a and not b then
        return nil
    else return math.min(a or math.huge, b or math.huge) end
end

--to rad
function torad(x)
    return x*math.pi/180
end

function music(dir)
    return love.audio.newSource('assets/audio/music/'..dir..'.wav', 'static')
end

function sfx(dir, s)
    if s then
        if file.exists('assets/audio/sfx/'..dir..'.mp3') then
            return love.audio.newSource('assets/audio/sfx/'..dir..'.mp3', 'static')
        end
    else
        if file.exists('assets/audio/sfx/'..dir..'.wav') then
            return love.audio.newSource('assets/audio/sfx/'..dir..'.wav', 'static')
        end
    end
end

function play(sfx)
    if not intable(audio.sfx, sfx) then
        audio.sfx[sfx] = love.audio.newSource('assets/audio/sfx/'..sfx..'.wav', 'static')
        audio.sfx[sfx]:setVolume(config.sfx)
    end
    audio.sfx[sfx]:stop()
    audio.sfx[sfx]:play()
end

function openlink(url)
    local c_os = package.config:sub(1,1)
    if c_os == '/' then os.exectute('xdg-open "'..url..'"'); return nil
    elseif c_os == ':' then os.execute('open '..url); return nil
    else os.execute('start '..url) end
    love.window.minimize()
end

--sorts a table by value v
function sort(t, v)
    local m = true
    while m do
        m = false
        for i=1, #t - 1 do
            if t[i][v] < t[i+1][v] then
                t[i], t[i+1] = t[i+1], t[i]
                m = true
            end
        end
    end
    return t
end

--loads image from sprites directory
function Image(name)
    return love.graphics.newImage('assets/sprites/'..name..'.png')
end

function capitalise(str)
    return (str:gsub("^%l", string.upper))
end

function round(num, dp)
    local mult = 10^(dp or 0)
    return math.floor(num * mult + 0.5)/mult
end

function todt(n)
    return n*60
end

function keydown(key)
    return love.keyboard.isDown(key)
end

function img(dir, r1, r2)
    local t = {}
    for i=r1, r2 do
        t[i] = love.graphics.newImage(dir..'-'..i..'.png')
    end
    return t
end

--scuffed probability where rerolls iter times if the result is not num
function rollagain(r1, r2, num, iter)
    local n = math.random(r1, r2)
    for i=1, iter do
        if n ~= num then
            n = math.random(r1, r2)
        end
    end
    return n
end

function tobin(b)
    if b then return 1 else return 0 end
end