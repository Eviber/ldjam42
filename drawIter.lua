local lg = love.graphics
colorPicker = require "colorPicker"

white = {r = 0.75, g = 0.75, b = 0.75, a = 1}
grey = {r = 0.375, g = 0.375, b = 0.375, a = 1}
black = {r = 0, g = 0, b = 0, a = 1}
colorTab = {white, grey, black}

function drawField (source)
	local i, j
	for i = 0, iter.width - 1 do
		for j = 0, iter.height - 1 do
			if getDist(i, j) < iter.decay and iter.field[i][j] < 0 then
				iter.field[i][j] = iter.field[i][j] * -1
			end
			if iter.field[i][j] == 1 then
				callColor(colorTab[((iter.id + 1) % 3) + 1])
				--[[else
				print("tile ["..i.." "..j.."]")]]
			end
			if iter.field[i][j] ~= -1 then
				lg.rectangle('fill', i * tileDim + (W - iter.width * tileDim) / 2, j * tileDim + (H - iter.height * tileDim) / 2, tileDim, tileDim)
			end
		end
	end
end

function printGameOver()
	lg.setColor(1, 0, 0, 1)
	gameOverFont = lg.setNewFont(50)
	lg.setFont(gameOverFont)
	lg.print("Game Over !", W/2 - 160, H/2 - 50)
	retryFont = lg.setNewFont(35)
	lg.setFont(retryFont)
	lg.print("Press space to restart", W/2 - 190, H/2 + 50)
end

local t = 0
local showHP = false
function printHealth()
	if Player.health < 100 then
		t = love.timer.getTime()
	end

	local a = 0.5 - (love.timer.getTime() - t) / 2 * 0.5
	if a > 0 then
		lg.setColor(1, 0, 0, a)

		local hp = 0
		local x  = (W - (4 * 25 * tileDim + 6 * tileDim)) / 2
		while hp < Player.health do
			lg.rectangle('fill', x, tileDim * 2, math.min(25, Player.health - hp) * tileDim, tileDim * 4)
			hp = hp + 25
			x  = x  + 27 * tileDim
		end
	end
end
