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

function printHealth()
	lg.setColor(1, 0, 0, 0.5)
	if Player.health > 75 then
		lg.rectangle('fill', 855, 15, (Player.health - 75) * 8, 25)
		lg.rectangle('fill', 640, 15, 200, 25)
		lg.rectangle('fill', 425, 15, 200, 25)
		lg.rectangle('fill', 210, 15, 200, 25)
	elseif Player.health > 50 then
		lg.rectangle('fill', 640, 15, (Player.health - 50) * 8, 25)
		lg.rectangle('fill', 425, 15, 200, 25)
		lg.rectangle('fill', 210, 15, 200, 25)
	elseif Player.health > 25 then
		lg.rectangle('fill', 425, 15, (Player.health - 25) * 8, 25)
		lg.rectangle('fill', 210, 15, 200, 25)
	else
		lg.rectangle('fill', 210, 15, Player.health * 8, 25)
	end
end
