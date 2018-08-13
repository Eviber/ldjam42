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
local realdx, realdy = 0, 0
local function applyvel(vel, deg, dt)
	if norm > 0 then
		realdx = realdx / norm * (norm - 10 * dt)
		realdy = realdy / norm * (norm - 10 * dt)
		norm = math.sqrt(realdx^2 + realdy^2)
		if norm < 1  and vel == 0 then
			realdx, realdy = 0, 0
		end
	end
	realdx = realdx + vel * math.cos(deg)
	realdy = realdy + vel * math.sin(deg)
	norm = math.sqrt(realdx^2 + realdy^2)
	if norm > 10 then
		realdx = realdx / norm * (10 + (norm - 10) / 2)
		realdy = realdy / norm * (10 + (norm - 10) / 2)
	end
	norm = math.sqrt(realdx^2 + realdy^2)
	return realdx, realdy
end

local deg = 0
local cd = 0
dirx, diry = 0, 0
function controls.getInput(dt)
	local dx,dy = 0,0
	local vel = 0

	if isDown('right') or isDown('d') then
		deg = deg + 3 * dt
	elseif isDown('left') or isDown('a') then
		deg = deg - 3 * dt
	end
	if isDown('up') or isDown('w') then
		vel = 15 * dt
	else
		vel = 0
	end
	if vel < 0 or vel > 10 then
		vel = vel < 0 and 0 or 10
	end
	if cd > 0 then
		cd = cd - dt
	elseif isDown('down') or isDown('space') then
		vel = vel + 100
		cd = 2
	end
	dx, dy = applyvel(vel, deg, dt)
	Player.x, Player.y = Player.x+dx, Player.y+dy
	dirx = Player.x + (20 * math.cos(deg))
	diry = Player.y + (20 * math.sin(deg))
	oob()
end

return controls
