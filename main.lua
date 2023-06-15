--libs
require 'libs.misc'
require 'libs.TSerial'
Object = require 'libs.classic'
Camera = require 'libs.Camera'
moonshine = require 'libs.moonshine'
file = require 'libs.file'
languages = require 'libs.languages'
steam = require 'luasteam'
json = require 'libs.dkjson'
http = require("socket.http")
utf8 = require("utf8")

steam.init()
steam.userStats.requestCurrentStats()

--rooms
game = require 'game'
endgame = require 'endgame'
menu = require 'menu'
settings = require 'settings'
change_language = require 'change_language'
change_difficulty = require 'change_difficulty'
view_map = require 'view_map'

--objs
Tower = require 'objects.tower'
Font = require 'objects.font'
Enemy = require 'objects.enemy'
Elite = require 'objects.elite'
Shop = require 'objects.shop'
Particles = require 'objects.particles'
Bullet = require 'objects.bullet'
lightning = require 'objects.lightning'

--children
Crossbow = require 'objects.crossbow'
Cannon = require 'objects.cannon'
Fist = require 'objects.hand'
Burner = require 'objects.burner'
Pot = require 'objects.pot'
Shotgun = require 'objects.shotgun'
Speedgun = require 'objects.speedgun'
Hose = require 'objects.hose'
Ritual = require 'objects.ritual'
Moneybag = require 'objects.moneybag'
Lmg = require 'objects.lmg'
Fan = require 'objects.fan'
Bazooka = require 'objects.bazooka'
Campfire = require 'objects.campfire'
Magnifier = require 'objects.magnifier'
Ice = require 'objects.ice'
Fridge = require 'objects.fridge'
Volcano = require 'objects.volcano'
Wizardtower = require 'objects.wizardtower'
Cloud = require 'objects.cloud'
Blackhole = require 'objects.blackhole'
Weight = require 'objects.weight'
Pirate = require 'objects.pirate'
Railgun = require 'objects.railgun'
Metropolis = require 'objects.metropolis'
Amp = require 'objects.amp'
Sniper = require 'objects.sniper'
Tricannon = require 'objects.tricannon'
Xpbooster = require 'objects.xpbooster'
Rent = require 'objects.rent'
Shapeshifter = require 'objects.shapeshifter'
Nailgun = require 'objects.nailgun'
Nuclear = require 'objects.nuclear'
Laserblaster = require 'objects.laserblaster'
Overload = require 'objects.overload'
Stopwatch = require 'objects.stopwatch'
Detonator = require 'objects.detonator'
Spikes = require 'objects.spikes'
Frostedspikes = require 'objects.frostedspikes'
Monkey = require 'objects.monkey'
Flamethrower = require 'objects.flamethrower'
Affliction = require 'objects.affliction'
Energizer = require 'objects.energizer'
Poison = require 'objects.poison'
Pesticide = require 'objects.pesticide'


--towers
names = {
    ['crossbow'] = {desc = 'shoots arrows with high range', var = 'attack', tier = 1, unit = 'ground/air'},
    ['cannon'] = {desc = 'fires slow explosive cannonballs', var = 'attack', tier = 1, unit = 'ground/air'},
    ['fist'] = {desc = 'weakens enemies and does huge damage', var = 'attack', tier = 1, unit = 'ground'},
    ['burner'] = {desc = 'burns adjacent tiles', var = 'attack', tier = 2, unit = 'ground'},
    ['pot'] = {desc = 'tips out boiling oil onto close tiles', var = 'attack', tier = 1, unit = 'ground'},
    ['shotgun'] = {desc = 'shoots a spray of bullets close range', var = 'attack', tier = 1, unit = 'ground/air'},
    ['hose'] = {desc = 'shoots out water that makes the enemies faster', var = 'support', tier = 3, unit = 'ground/air'},
    ['speedgun'] = {desc = 'does damage scaled by the enemy\'s speed', var = 'attack', tier = 2, unit = 'ground/air'},
    ['ritual'] = {desc = 'summons a portal that teleports enemies back to then start', var = 'attack', tier = 2, unit = 'ground/air'},
    ['lmg'] = {desc = 'shoots rapid projectiles at air enemies', var = 'attack', tier = 2, unit = 'air'},
    ['moneybag'] = {desc = 'gains extra gold during a wave', var = 'support', tier = 2, unit = 'NA'},
    ['fan'] = {desc = 'pushes enemies back', var = 'support', tier = 1, unit = 'ground/air'},
    ['bazooka'] = {desc = 'shoots huge rockets with enormous explosions', var = 'attack', tier = 3, unit = 'ground/air'},
    ['campfire'] = {desc = 'all fire damage in range is increased', var = 'support', tier = 2, unit = 'ground/air'},
    ['magnifier'] = {desc = 'shoots a beam of light that does burning damage', var = 'attack', tier = 1, unit = 'ground'},
    ['ice'] = {desc = 'shoots iceblocks that freeze enemies for a brief period of time', var = 'attack', tier = 2, unit = 'ground/air'},
    ['fridge'] = {desc = 'opens and does slow effect in range', var = 'support', tier = 1, unit = 'ground/air'},
    ['volcano'] = {desc = 'spills hot lava onto adjacent tiles', var = 'attack', tier = 3, unit = 'ground'},
    ['wizardtower'] = {desc = 'shoots chain lightning projectiles', var = 'attack', tier = 3, unit = 'ground/air'},
    ['cloud'] = {desc = 'shoots water that does lightning damage on level up', var = 'attack', tier = 3, unit = 'ground/air'},
    ['blackhole'] = {desc = 'sucks nearby enemies in to the centre', var = 'support', tier = 2, unit = 'ground/air'},
    ['weight'] = {desc = 'does huge damage and grounds air enemies', var = 'attack', tier = 2, unit = 'air'},
    ['pirate'] = {desc = 'does damage scaled off leftover gold', var = 'attack', tier = 3, unit = 'ground'},
    ['railgun'] = {desc = 'starts slow and shoots faster over time', var = 'attack', tier = 3, unit = 'ground/air'},
    ['metropolis'] = {desc = 'does extra damage for each adjacent tower', var = 'attack', tier = 2, unit = 'ground/air'},
    ['amp'] = {desc = 'weakens all enemies in radius', var = 'support', tier = 3, unit = 'ground/air'},
    ['sniper'] = {desc = 'targets a random enemy and does huge damage', var = 'attack', tier = 2, unit = 'ground/air'},
    ['tricannon'] = {desc = 'fires much weaker cannonballs in three directions', var = 'attack', tier = 3, unit = 'ground/air'},
    ['xpbooster'] = {desc = 'gives xp to all adjacent tiles upon purchase', var = 'support', tier = 2, unit = 'NA'},
    ['rent'] = {desc = 'increases max towers but takes 2 gold at the start of turn', var = 'support', tier = 3, unit = 'NA'},
    ['shapeshifter'] = {desc = 'turns into a random tower each round', var = 'attack', tier = 2, unit = 'NA'},
    ['nailgun'] = {desc = 'shoots rapid nails that do extra damage to enemies without status effects', var = 'attack', tier = 4, unit = 'ground/air'},
    ['nuclear'] = {desc = 'shoots barrels of radioactive liquid', var = 'attack', tier = 4, unit = 'ground/air'},
    ['laserblaster'] = {desc = 'shoots high damage lasers in four directions', var = 'attack', tier = 4, unit = 'ground'},
    ['overload'] = {desc = 'enhances a random close attack tower', var = 'support', tier = 4, unit = 'NA'},
    ['stopwatch'] = {desc = 'freezes all enemies briefly', var = 'attack', tier = 4, unit = 'ground/air'},
    ['detonator'] = {desc = 'shoots dynamite that explodes after a period of time simultaneously', var = 'attack', tier = 4, unit = 'ground/air'},
    ['spikes'] = {desc = 'leaves spikes on the track', var = 'attack', tier = 3, unit = 'ground'},
    ['frostedspikes'] = {desc = 'leaves freezing spikes on the track', var = 'attack', tier = 4, unit = 'ground'},
    ['monkey'] = {desc = 'throws darts', var = 'attack', tier = 1, unit = 'ground/air'},
}

--[[
tier 1 (8):
crossbow
cannon
fist
pot
shotgun
fan
magnifier
fridge

tier 2 (13):
burner
lmg
sniper
ritual
moneybag
campfire
speedgun
ice
blackhole
weight
metropolis
xpbooster
shapeshifter

tier 3 (11):
road spikes
hose
bazooka
volcano
wizard tower
cloud
pirate
railgun
amp
tricannon
rent

tier 4 (7):
frosted spikes
shredder nailguns (shoots alot of bullets, does extra dmg to enemies without status effects)
laser
stopwatch
detonator (puts mines on enemies and detonates them all at once)
nuclear (enemies give of an aura that damages other enemies)
overload (chooses an adjacent tower and buffs it for that round randomly)

tier 5 (5):
poison (leaves pools of poison)
energized (fast and zaps nearby enemies)
flamethrower (shoots lots of fire)
afflicted (does dmg scaled off the amount of effects on an enemy)
pesticide (only activated while elites are around, does enormous single target damage)
]]

--[[
slug
ant
cockroach
mosquito
caterpillar
fly
ladybug
butterfly
bee
mantis
moth
snail
spider
dragonfly
beetle
]]
bugs = {
    ['slug'] = {unit = 'ground', hp = 8, speed = todt(0.3)},
    ['cockroach'] = {unit = 'ground', hp = 12, speed = todt(0.5)},
    ['mosquito'] = {unit = 'air', hp = 3, speed = todt(1)},

    ['ant'] = {unit = 'ground', hp = 17, speed = todt(0.5)},
    ['fly'] = {unit = 'air', hp = 10, speed = todt(0.5)},

    ['caterpillar'] = {unit = 'ground', hp = 29, speed = todt(0.4)},
    ['ladybug'] = {unit = 'air', hp = 14, speed = todt(0.4)},
    ['bee'] = {unit = 'air', hp = 9, speed = todt(1.3)},

    ['mantis'] = {unit = 'ground', hp = 32, speed = todt(0.7)},
    ['butterfly'] = {unit = 'air', hp = 19, speed = todt(0.6)},

    ['spider'] = {unit = 'ground', hp = 45, speed = todt(0.8)},
    ['moth'] = {unit = 'air', hp = 25, speed = todt(0.9)},
    ['snail'] = {unit = 'ground', hp = 500, speed = todt(0.2)},
    ['dragonfly'] = {unit = 'air', hp = 18, speed = todt(1.3)},


    ['beetle'] = {unit = 'ground', hp = 90, speed = todt(1.1)},
}

tier = 1

--translations[word][language] you fucken idiot
translations = languages.load()

waves = {
    {{'slug', 4}},
    {{'slug', 6}, {'cockroach', 2}},
    {{'slug', 4}, {'cockroach', 4}, {'mosquito', 4}}, --3

    {{'ant', 2}, {'cockroach', 6}, {'mosquito', 6}},
    {{'ant', 6}, {'cockroach', 8}, {'slug', 20}},
    {{'ant', 10}, {'fly', 4}},
    {{'ant', 8}, {'cockroach', 15}, {'fly', 10}}, --7

    {{'caterpillar', 8}, {'ant', 6}, {'mosquito', 20}},
    {{'caterpillar', 8}, {'ant', 15}, {'bee', 8}},
    {{'ladybug', 6}, {'fly', 12}, {'bee', 6}},
    {{'caterpillar', 15}, {'ant', 25}, {'bee', 10}},
    {{'caterpillar', 12}, {'ladybug', 12}}, --12

    {{'mantis', 6}, {'caterpillar', 12}, {'ladybug', 16}},
    {{'mantis', 8}, {'fly', 25}, {'caterpillar', 20}},
    {{'mantis', 14}, {'butterfly', 5}, {'ladybug', 15}},
    {{'butterfly', 7}, {'ladybug', 17}, {'fly', 27}, {'mosquito', 37}}, --16

    {{'spider', 10}, {'moth', 2}, {'butterfly', 5}},
    {{'snail', 1}, {'dragonfly', 5}},
    {{'spider', 15}, {'moth', 5}, {'butterfly', 10}, {'mantis', 15}, {'mosquito', 100}},
    {{'beetle', 1}, {'snail', 1}, {'spider', 20}, {'dragonfly', 15}, {'moth', 10}} --20
}
towertier = {3, 7, 12, 16}


audio = {}
audio.music = {
    building = music('building'),
    menu = music('menu'),
    wave = music('wave')
}
clouds = {}
audio.sfx = {
    --button = sfx('button'),
    --buy = sfx('buy', 'm'),
    explosion = sfx('explosion'),
    button = sfx('button'),
    freeze = sfx('freeze'),
    --gaincoin = sfx('gaincoin'),
    gameover = sfx('gameover', 'm'),
    gamewon = sfx('gamewon', 'm'),
    --laser = sfx('laser'),
    loselife = sfx('loselife'),
    --maxtowers = sfx('maxtowers', 'm'),
    newtowers = sfx('newtowers', 'm'),
    sell = sfx('sell'),
    merge = sfx('merge'),
    takedmg = sfx('takedmg'),
    --waveend = sfx('waveend', 'm'),
    wavestart = sfx('wavestart', 'm'),
    reroll = sfx('reroll', 'm'),
    placetower = sfx('placetower')
}

difficulty_towers = {
    ['flamethrower'] = {desc = 'blasts torrents of blazing fire', var = 'attack', tier = 5, unit = 'ground/air'},
    ['affliction'] = {desc = 'does damage scaled on active effects', var = 'attack', tier = 5, unit = 'ground/air'},
    ['energizer'] = {desc = 'makes huge chains of lignting', var = 'attack', tier = 5, unit = 'ground/air'},
    ['poison'] = {desc = 'leaves pools of poison', var = 'attack', tier = 5, unit = 'ground/air'},
    ['pesticide'] = {desc = 'does enormous damage to elites', var = 'attack', tier = 5, unit = 'ground'}
}

for name, v in pairs(names) do
    audio.sfx[name] = sfx('towers/'..name)
end

for name, v in pairs(difficulty_towers) do
    audio.sfx[name] = sfx('towers/'..name)
end

love.audio.play(audio.music.menu)

config = {}

function load_settings()
    if file.exists('settings.txt') then
        lines = file.read('settings.txt')
        lines = lines[1]
    else
        lines = 'sfx:0.6,music:1,ui:150,camera:false,difficulty:0,language:english,tutorial:false,max_difficulty:0'
    end

    lines = split(lines, ',')

    for _, line in ipairs(lines) do
        local s = split(line, ':')
        if isnum(s[2]) then s[2] = tonumber(s[2]) end
        config[s[1]] = boolify(s[2])
    end
end

load_settings()

for _, v in pairs(audio.music) do v:setVolume(config['music']); v:setLooping(true) end
for _, v in pairs(audio.sfx) do v:setVolume(config['sfx']) end


lang_fonts = {
    ['general'] = {'bulgarian', 'czech', 'danish', 'dutch', 
    'finnish', 'french', 'german', 'greek', 'hindi', 'hungarian', 'italian',
    'norwegian', 'polish', 'portuguese', 'romanian', 'russian', 'spanish',
    'swedish', 'turkish', 'ukrainian', 'vietnamese'},
    ['alternate'] = {'arabic', 'chinese_(simplified)', 'chinese_(traditional)', 
    'japanese', 'korean', 'punjabi', 'thai'},
    ['otf'] = {'chinese_(simplified)', 'chinese_(traditional)', 'korean'}
}
 
--[[
    elitespawn: the chance of an elite spawning (0, 5, 10, 15, 20)%
    towerplus: additional tower slots granted (scales with wave) (0, 1, 1, 2, 2)
    health: the health multiplier (1, 1.1, 1.2, 1.3, 1.6)
    speed: the speed multiplier (1, 1.1, 1.1, 1.2, 1.4)
    effects: the possible effects (none -> all)
]]

effects = {
    ['wings'] = {on = false, colour = {255, 255, 255}},
    ['speed'] = {on = false, increase = todt(0.3), colour = {255, 255, 0}},
    ['buff'] = {on = false, increase = 1.5, colour = {255, 0, 0}},
    ['path'] = {on = false, colour = {0, 255, 255}},
--    ['backwards'] = {on = true},
    ['swarm'] = {on = false, colour = {255, 255,0}},
    ['regen'] = {on = false, effect = {'regen'}, stats = {{ratedur = 10, hp = 4, ratetimer = 1.5}}, colour = {250,128,114}},
    ['snow'] = {on = false, effect = {'slow'}, stats = {{ratedur = 6, slow = todt(0.2)}}, colour = {230, 230, 230}},
    ['freeze'] = {on = false, effect = {'freeze'}, stats = {{ratedur = 1}}, colour = {215, 229, 240}},
    ['humid'] = {on = false, effect = {'wet', 'burn'}, stats = {{ratedur = 2.5, speed = todt(0.3)}, {ratedur = 2.5, ratetimer = 0.2, dmg = 2}}, colour = {255,165,0}},
    ['acid'] = {on = false, effect = {'wet', 'radiate'}, stats = {{ratedur = 2.5, speed = todt(0.5)}, {ratedur = 2.5, dmg = 0.1, radius = 32}}, colour = {100,205,100}}
}

difficulty = {
    {elitespawn = 0, towers = {4, 5, 6, 8, 8}, health = 1, speed = 1, number = 1},
    {elitespawn = 0.03, towers = {4, 6, 7, 8, 9}, health = 1.1, speed = 1.1, number = 1.1, effects = {'snow', 'freeze'}, tower = 'flamethrower'},
    {elitespawn = 0.1, towers = {5, 7, 8, 9, 10}, health = 1.15, speed = 1.1, number = 1.2, effects = {'snow', 'freeze', 'humid', 'acid'}, tower = 'energizer'},
    {elitespawn = 0.15, towers = {5, 8, 9, 10, 11}, health = 1.2, speed = 1.2, number = 1.3, effects = {'snow', 'freeze', 'humid', 'acid', 'regen', 'buff'}, tower = 'affliction'},
    {elitespawn = 0.2, towers = {6, 9, 10, 11, 12}, health = 1.3, speed = 1.4, number = 1.5, effects = {'wings', 'speed', 'buff', 'path', 'swarm', 'regen', 'snow', 'freeze', 'humid', 'acid'}, tower = {'poison', 'pesticide'}},
}

music_starting = {
    wave = {0, 47.2262, 85.936},
    base = {0, 57.6, 72, 127.2, 141.6}
}

for k, v in pairs(difficulty) do
    difficulty[k].desc = {{'elite spawn rate', (v.elitespawn*100)..'%'}, {'max towers', v.towers}, {'health increase', ((v.health-1)*100)..'%'},
    {'speed increase', ((v.speed-1)*100)..'%'}}
    if k > 1 then
        table.insert(difficulty[k].desc, {'enemy amount', ((v.number-1)*100)..'%'})
        table.insert(difficulty[k].desc, {'new tower', v.tower})
        table.insert(difficulty[k].desc, {'possible effects', v.effects})
    end
end

function update_towers()
    for k, v in pairs(difficulty) do
        if k > 1 then
            if type(v.towers[2]) == 'table' then
                tower1, tower2 = unpack(v.tower[2])
            else
                tower1, tower2 = v.tower, nil
            end

            if config.difficulty + 1 >= k then
                if tower2 ~= nil then
                    names[tower2] = nil
                    names[tower2] = difficulty_towers[tower2]
                end
                if not names[tower1] then
                    names[tower1] = difficulty_towers[tower1]
                end
            else
                if tower2 ~= nil then
                    names[tower2] = nil
                end
                names[tower1] = nil
            end
        end
    end
end

update_towers()

towertier = {3, 6, 9, 14, 17}
wavetowers = difficulty[config.difficulty+1].towers

scale = 0

hitflash = love.graphics.newShader[[
vec4 effect(vec4 vcolor, Image tex, vec2 texcoord, vec2 pixcoord)
{
    float WhiteFactor = 1;
    vec4 outputcolor = Texel(tex, texcoord) * vcolor;
    outputcolor.rgb += vec3(WhiteFactor);
    return outputcolor;
}
]]

-- LÖVE 0.10.2 fixed timestep loop, Lua version
function love.run()
    if love.load then love.load(arg) end
    if love.timer then love.timer.step() end

    local dt = 0
    local fixed_dt = 1/60
    local accumulator = 0

    while true do
        if love.event then
            love.event.pump()
            for name, a, b, c, d, e, f in love.event.poll() do
                if name == 'quit' then
                    if not love.quit or not love.quit() then
                        return a
                    end
                end
                love.handlers[name](a, b, c, d, e, f)
            end
        end

        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        accumulator = accumulator + dt
        while accumulator >= fixed_dt do
            if love.update then love.update(fixed_dt) end
            accumulator = accumulator - fixed_dt
        end

        if love.graphics and love.graphics.isActive() then
            love.graphics.clear(love.graphics.getBackgroundColor())
            love.graphics.origin()
            if love.draw then love.draw() end
            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.0001) end
    end
end



function love.errorhandler(msg)
    local url = "https://eotwcsywwksc8ia.m.pipedream.net"

	msg = tostring(msg)

	if not love.window or not love.graphics or not love.event then
		return
	end

	if not love.graphics.isCreated() or not love.window.isOpen() then
		local success, status = pcall(love.window.setMode, 800, 600)
		if not success or not status then
			return
		end
	end

	-- Reset state.
	if love.mouse then
		love.mouse.setVisible(true)
		love.mouse.setGrabbed(false)
		love.mouse.setRelativeMode(false)
		if love.mouse.isCursorSupported() then
			love.mouse.setCursor()
		end
	end
	if love.joystick then
		-- Stop all joystick vibrations.
		for i,v in ipairs(love.joystick.getJoysticks()) do
			v:setVibration()
		end
	end
	if love.audio then love.audio.stop() end

	love.graphics.reset()
	local font = love.graphics.setNewFont(14)

	love.graphics.setColor(1, 1, 1)

	local trace = debug.traceback()

	love.graphics.origin()

	local sanitizedmsg = {}
	for char in msg:gmatch(utf8.charpattern) do
		table.insert(sanitizedmsg, char)
	end
	sanitizedmsg = table.concat(sanitizedmsg)

	local err = {}

	table.insert(err, "Error\n")
	table.insert(err, sanitizedmsg)

	if #sanitizedmsg ~= #msg then
		table.insert(err, "Invalid UTF-8 string in error message.")
	end

	table.insert(err, "\n")

	for l in trace:gmatch("(.-)\n") do
		if not l:match("boot.lua") then
			l = l:gsub("stack traceback:", "Traceback\n")
			table.insert(err, l)
		end
	end

	local p = table.concat(err, "\n")

	p = p:gsub("\t", "")
	p = p:gsub("%[string \"(.-)\"%]", "%1")

  sent = false

	local function draw()
		if not love.graphics.isActive() then return end
		local pos = 70
		love.graphics.clear(89/255, 157/255, 220/255)
		love.graphics.printf(p, pos, pos, love.graphics.getWidth() - pos)
		love.graphics.present()
    if not sent then
      local sending = p
      sending = sending..' '..config.language
      local success, _, _, _, _ = http.request{
        url = url,
        method = "POST",
        headers = {
          ["Content-Type"] = "application/json",
          ['player_id'] = sending:gsub('\n', '')
        },
      }
      sent = success
    end
	end

	local fullErrorText = p
	local function copyToClipboard()
		if not love.system then return end
		love.system.setClipboardText(fullErrorText)
		p = p .. "\nCopied to clipboard!"
	end

	if love.system then
		p = p .. "\n\nThis error will be automatically sent to the developer provided you have an internet connection!"
	end

	return function()
		love.event.pump()

		for e, a, b, c in love.event.poll() do
			if e == "quit" then
				return 1
			elseif e == "keypressed" and a == "escape" then
				return 1
			elseif e == "keypressed" and a == "c" and love.keyboard.isDown("lctrl", "rctrl") then
				copyToClipboard()
			elseif e == "touchpressed" then
				local name = love.window.getTitle()
				if #name == 0 or name == "Untitled" then name = "Game" end
				local buttons = {"OK", "Cancel"}
				if love.system then
					buttons[3] = "Copy to clipboard"
				end
				local pressed = love.window.showMessageBox("Quit "..name.."?", "", buttons)
				if pressed == 1 then
					return 1
				elseif pressed == 3 then
					copyToClipboard()
				end
			end
		end

		draw()

		if love.timer then
			love.timer.sleep(0.1)
		end
	end
end

function love.load()
    --room management
    current_room = 'menu'
    prev_room = ''
    love.window.setFullscreen(true)
    math.randomseed(os.time())

    love.window.setTitle('bugTDX')
    love.window.setIcon(love.image.newImageData('assets/sprites/icon.png'))

    --video settings
    window = {}
    window.x, window.y = love.graphics.getDimensions()
    window.scale = config.ui/100
    world = {
        x = window.x/window.scale,
        y = window.y/window.scale
    }
    centre = {
        x = world.x/2,
        y = world.y/2
    }
    mouse = {
        x = 0,
        y = 0
    }
    love.graphics.setDefaultFilter('nearest', 'nearest')
    canvas = love.graphics.newCanvas(window.x/window.scale, window.y/window.scale)

    font_sizes = {
        ['main'] = 20,
        ['desc'] = 10,
        ['bought'] = 14,
        ['wave'] = 50,
        ['huge'] = 60,
        ['settings'] = 35,
        ['freeze'] = 13
    }
    font = {}
    font.english = {}

    for k, v in pairs(font_sizes) do
        font['english'][k] = love.graphics.newFont('assets/fonts/PixulBrush.ttf', v)
    end

    font_sizes.main = 25
    font_sizes.desc = 15
    font_sizes.bought = 20
    font_sizes.freeze = 20

    for _, v in pairs(lang_fonts['general']) do
        font[v] = {}
        for name, s in pairs(font_sizes) do
            font[v][name] = love.graphics.newFont('assets/fonts/universals/general.ttf', s)
        end
    end

    for _, v in pairs(lang_fonts['otf']) do
        font[v] = {}
        for name, s in pairs(font_sizes) do 
            font[v][name] = love.graphics.newFont('assets/fonts/universals/'..v..'.otf', s)
        end
    end

    for _, v in pairs(lang_fonts['alternate']) do
        if not font[v] then
            font[v] = {}
            for name, s in pairs(font_sizes) do
                font[v][name] = love.graphics.newFont('assets/fonts/universals/'..v..'.ttf', s)
            end
        end
    end

    languages.update_font('main')
    started = false

    _G[current_room].load()
end

function love.update(dt)
    mouse.x, mouse.y = love.mouse.getX()/window.scale, love.mouse.getY()/window.scale

    if current_room then
        prev_room = _G[current_room].update(dt)
        if prev_room ~= current_room then
            if not started then
                _G[prev_room].load()
                if prev_room == 'game' then
                    started = true
                end            
            elseif prev_room ~= 'game' then
                _G[prev_room].load()
            end
            current_room = prev_room
        end
    end
end

function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.setLineStyle('rough')

    love.graphics.setBackgroundColor(0,181/255,226/255)

    if current_room then _G[current_room].draw() end

    love.graphics.setCanvas()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(canvas, 0, 0, 0, window.scale, window.scale )
    love.graphics.setBlendMode('alpha')
end

function love.keypressed(key)
    if _G[current_room].keypressed ~= nil then
        _G[current_room].keypressed(key)
    end
    if key == 's' then love.audio.stop() end
end

function quit()
    save_settings()
    steam.shutdown()
    love.event.quit()
end


function love.mousepressed(x, y, button)
    if _G[current_room].mousepressed ~= nil then
        _G[current_room].mousepressed(x, y, button)
    end
end