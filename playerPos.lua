interaction = require "playerInteraction"

local tileX
local tileY
local immunityTimer

function getPos(x, y)
	tileX = math.floor(x / 8)
	tileY = math.floor(y / 8)
	return tileX, tileY
end

function posReact(dt)
	tileX, tileY = getPos(Player.x, Player.y)
	if iter.field[tileX][tileY] < 0 then
		immunityTimer = immunityTimer + dt
		if immunityTimer >= 0.5 then
			voidDamage()
			screen:setShake(2)
		end
	else
		immunityTimer = 0
	end
	for i = -3, 3 do
		for j = -3, 3 do
			local x, y = tileX + i, tileY + j
			if x >= 0 and y >= 0 then
				local val = math.abs(iter.field[tileX + i][tileY + j])
				local xx, yy = x * tileDim - tileDim / 2, y * tileDim - tileDim / 2
				if math.sqrt((xx - Player.x)^2 + (yy - Player.y)^2) < 20 and val > 1 then
					itemList[val].interact(itemList[val])
				end
			end
		end
	end
end

