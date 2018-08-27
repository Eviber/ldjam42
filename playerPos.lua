interaction = require "playerInteraction"

local tileX
local tileY
local immunityTimer


function getPos(x, y)
	tileX = math.floor(x / tileDim)
	tileY = math.floor(y / tileDim)
	return tileX, tileY
end

function posReact(dt)
	tileX, tileY = getPos(Player.x, Player.y)
	if iter.field[tileX][tileY] < 0 then
		immunityTimer = immunityTimer + dt
		if immunityTimer >= 0.5 then
			voidDamage(dt)
			screen:setShake(2)
			if Player.health <= 0 then gameOver = true end
		end
	else
		immunityTimer = 0
		Player.health = healthRegen(dt)
	end
	for i = -10, 10 do
		for j = -10, 10 do
			local x, y = tileX + i, tileY + j
			if x >= 0 and y >= 0 and x < iter.width and y < iter.height then
				local val = math.abs(iter.field[tileX + i][tileY + j])
				local xx, yy = x * tileDim + tileDim / 2, y * tileDim + tileDim / 2
				if math.sqrt((xx - Player.x)^2 + (yy - Player.y)^2) < 7 * tileDim and val > 1 --[[and itemList[val].val ~= 4]] then
					itemList[val].interact(itemList[val])
				end
			end
		end
	end
end

