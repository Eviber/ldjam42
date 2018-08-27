local controls = {}

local lg = love.graphics
local isDown = love.keyboard.isDown

local function oob()
	collision = false
	if (Player.x > W - Player.w or Player.x < 0) then
		Player.x = Player.x < 0 and 0 or W - Player.w
		collision = true
	end
	if (Player.y > H - Player.h or Player.y < 0) then
		Player.y = Player.y < 0 and 0 or H - Player.h
		collision = true
	end
end

norm = 0
speed = 0
realdx, realdy = 0, 0
local function applyvel(vel, deg, dt)
	local max = tileDim * 10/8
	if norm > 0 then
		realdx = realdx / norm * (norm - max * dt)
		realdy = realdy / norm * (norm - max * dt)
		norm = math.sqrt(realdx^2 + realdy^2)
		if norm < 1  and vel == 0 then
			realdx, realdy = 0, 0
		end
	end
	realdx = realdx + vel * math.cos(deg)
	realdy = realdy + vel * math.sin(deg)
	norm = math.sqrt(realdx^2 + realdy^2)
	if norm > max then
		realdx = realdx / norm * (max + (norm - max) / 2)
		realdy = realdy / norm * (max + (norm - max) / 2)
	end
	norm = math.sqrt(realdx^2 + realdy^2)
	speed = norm/max*10
	return realdx, realdy
end

local cd = 0
local deg = 0
dirx, diry = 0, 0
function controls.getInput(dt)
	local dx,dy = 0,0
	local vel = 0

	if isDown('right') or isDown('d') then
		deg = deg + 4 * dt
	elseif isDown('left') or isDown('a') then
		deg = deg - 4 * dt
	end
	if isDown('up') or isDown('w') then
		vel = tileDim * 15/8 * dt
	else
		vel = 0
	end
	if vel < 0 or vel > tileDim * 10/8 then
		vel = vel < 0 and 0 or tileDim * 10/8
	end
	if cd > 0 then
		cd = cd - dt
	end
	if burst then
		burst = false
		vel = vel + tileDim * 100/8
	end
	dx, dy = applyvel(vel, deg, dt)
	Player.x, Player.y = Player.x+dx, Player.y+dy
	dirx = Player.x + (3 * tileDim * math.cos(deg))
	diry = Player.y + (3 * tileDim * math.sin(deg))
	oob()
end

function love.keypressed(key)
	if cd <= 0 and key == 'space' then
		cd = 2
		burst = true
	end
end

return controls
