local lg = love.graphics
colorPicker = require "colorPicker"

white = {r = 1, g = 1, b = 1, a = 1}
grey = {r = 0.5, g = 0.5, b = 0.5, a = 1}
black = {r = 0, g = 0, b = 0, a = 1}
colorTab = {white, grey, black}

function drawField (source)
	local i, j
	lg.setColor(255, 255, 255, 255)
	for i = 0, iter.width - 1 do
		for j = 0, iter.height - 1 do
			if iter.field[i][j] == 1 then
				callColor(colorTab[(iter.id % 3) + 1])
				--[[else
				print("tile ["..i.." "..j.."]")]]
			elseif math.abs(iter.field[i][j]) == 2 then
				callColor(colorTab[((iter.id + 2) % 3) + 1])
			elseif math.abs(iter.field[i][j]) == 3 then
				lg.setColor(0, 1, 0, 1)
			elseif math.abs(iter.field[i][j]) == 4 then
				lg.setColor(1, 0, 0, 1)
			elseif math.abs(iter.field[i][j]) == 5 or math.abs(iter.field[i][j]) == 6 or math.abs(iter.field[i][j]) == 7 then
				lg.setColor(1, 1, 0, 1)
			else
				callColor(colorTab[((iter.id + 1) % 3) + 1])
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
