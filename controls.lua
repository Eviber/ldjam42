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

function controls.getInput()
	local dx,dy = 0,0
	if isDown('right') or isDown('d') then
		dx = 10
	elseif isDown('left') or isDown('a') then
		dx = -10
	end
	if isDown('up') or isDown('w') then
		dy = -10
	elseif isDown('down') or isDown('s') then
		dy = 10
	end
	Cursor.x, Cursor.y = Cursor.x+dx, Cursor.y+dy
	oob()
end

return controls
