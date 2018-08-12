interaction = require "playerInteraction"

local tileX
local tileY
local immunityTimer

function getPos(x, y)
	tileX = math.floor(x / 4)
	tileY = math.floor(y / 4)
	return tileX, tileY
end

function posReact(dt)
	tileX, tileY = getPos(Player.x, Player.y)
	if iter.field[tileX][tileY] < 0 then
		immunityTimer = immunityTimer + dt
		if immunityTimer >= 0.5 then
			voidDamage()
		end
	else
		immunityTimer = 0
	end
end


