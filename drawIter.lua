local lg = love.graphics
colorPicker = require "colorPicker"

white = {r = 1, g = 1, b = 1, a = 1}
grey = {r = 0.5, g = 0.5, b = 0.5, a = 1}
black = {r = 0, g = 0, b = 0, a = 1}
colorTab = {white, grey, black}

function drawField (source)
	local i, j
	for i = 0, iter.width - 1 do
		for j = 0, iter.height - 1 do
			if iter.field[i][j] == 1 then
				callColor(colorTab[((iter.id + 1) % 3) + 1])
				--[[else
				print("tile ["..i.." "..j.."]")]]
			elseif math.abs(iter.field[i][j]) == 2 then
				callColor(colorTab[((iter.id + 2) % 3) + 1])
			end
			if iter.field[i][j] ~= -1 then
				lg.rectangle('fill', i * tileDim + (W - iter.width * tileDim) / 2, j * tileDim + (H - iter.height * tileDim) / 2, tileDim, tileDim)
			end
		end
	end
	--[[lg.setColor(0, 2, 10, 255)
	for i = 1, iter.width - 1 do
	lg.rectangle('fill', (i * tileDim) - 1 + (W - iter.width * tileDim) / 2, (H - iter.height * tileDim) / 2, 2, H - (H - iter.height * tileDim))
	end
	for j = 1, iter.height - 1 do
	lg.rectangle('fill', (W - iter.width * tileDim) / 2, (j * tileDim) - 1 + (H - iter.height * tileDim) / 2, W - (W - iter.width * tileDim), 2)
	end]]
end

function printGameOver()
	lg.setColor(1, 0, 0, 1)
	gameOverFont = lg.setNewFont(50)
	lg.setFont(gameOverFont)
	lg.print("Game Over !", W/2 - 160, H/2 - 50)
end

function printHealth()
	lg.setColor(1, 0, 0, 1)
	if Player.health > 75 then
		lg.rectangle('fill', 86, 5, Player.health - 75, 10)
		lg.rectangle('fill', 59, 5, 25, 10)
		lg.rectangle('fill', 32, 5, 25, 10)
		lg.rectangle('fill', 5, 5, 25, 10)
	elseif Player.health > 50 then
		lg.rectangle('fill', 59, 5, Player.health - 50, 10)
		lg.rectangle('fill', 32, 5, 25, 10)
		lg.rectangle('fill', 5, 5, 25, 10)
	elseif Player.health > 25 then
		lg.rectangle('fill', 32, 5, Player.health - 25, 10)
		lg.rectangle('fill', 5, 5, 25, 10)
	else
		lg.rectangle('fill', 5, 5, Player.health, 10)
	end
end
