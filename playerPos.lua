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
	local val = math.abs(iter.field[tileX][tileY])
	if val > 1 then
		itemList[val].interact(itemList[val])
	end
end

