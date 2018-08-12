local controls = {}

local lg = love.graphics
local isDown = love.keyboard.isDown

local function oob()
	collision = false
	if (Cursor.x > W - Cursor.w or Cursor.x < 0) then
		Cursor.x = Cursor.x < 0 and 0 or W - Cursor.w
		collision = true
	end
	if (Cursor.y > H - Cursor.h or Cursor.y < 0) then
		Cursor.y = Cursor.y < 0 and 0 or H - Cursor.h
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
		realdx = realdx / norm * 10
		realdy = realdy / norm * 10
	end
	norm = math.sqrt(realdx^2 + realdy^2)
	return realdx, realdy
end

local deg = 0
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
		vel = vel < 0 and 0 or 5
	end
	dx, dy = applyvel(vel, deg, dt)
	Cursor.x, Cursor.y = Cursor.x+dx, Cursor.y+dy
	dirx = Cursor.x + (20 * math.cos(deg))
	diry = Cursor.y + (20 * math.sin(deg))
	oob()
end

return controls
