local lg = love.graphics
local transi

tileCount = 0

local function setTransi(r)
	local x, y = math.random(0, iter.width - 1), math.random(0, iter.height - 1)
	local dx = x * tileDim + tileDim / 2 - W / 2
	local dy = y * tileDim + tileDim / 2 - H / 2
	if math.sqrt(dx^2 + dy^2) <= r and not transi[x][y] then
		transi[x][y] = true
		tileCount = tileCount + 1
		return true
	else
		return false
	end
end

function growTransi(dt)
	for _ = 0, 5000 * dt do
		local i = 0
		while not setTransi(transiRad) and i < 50 do i = i + 1 end
	end
	for _ = 0, 2500 * dt do
		local i = 0
		while not setTransi(transiRad * 3 / 4) and i < 50 do i = i + 1 end
	end
	for _ = 0, 1250 * dt do
		local i = 0
		while not setTransi(transiRad / 2) and i < 50 do i = i + 1 end
	end
	for _ = 0, 675 * dt do
		local i = 0
		while not setTransi(transiRad / 4) and i < 50 do i = i + 1 end
	end
end

function drawTransition()
	callColor(colorTab[(iter.id + 2) % 3 + 1])
	for i = 0, iter.width - 1 do
		for j = 0, iter.height - 1 do
			if transi[i][j] then
				local x = i * tileDim + (W - iter.width * tileDim) / 2
				local y = j * tileDim + (H - iter.height * tileDim) / 2
				lg.rectangle('fill', x, y, tileDim, tileDim)
			end
		end
	end
	lg.circle('line', W/2, H/2, transiRad)
end

function resetTransi()
	tileCount = 0
	transi = transi or {}
	for i = 0, iter.width - 1 do
		transi[i] = transi[i] or {}
		for j = 0, iter.height - 1 do
			transi[i][j] = false
		end
	end
end
