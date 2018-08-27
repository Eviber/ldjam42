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

	hitbox = {}
	hitbox.rad = (speed/4 + 3) * tileDim
	hitbox.x   = Player.x
	hitbox.y   = Player.y
	hitbox.x2  = Player.x + (Player.x - dirx) * math.min(3/speed, 1)
	hitbox.y2  = Player.y + (Player.y - diry) * math.min(3/speed, 1)
	tileX, tileY = getPos(hitbox.x, hitbox.y)
	for i = -10, 10 do
		for j = -10, 10 do
			local x, y = tileX + i, tileY + j
			if x >= 0 and y >= 0 and x < iter.width and y < iter.height then
				local val = math.abs(iter.field[tileX + i][tileY + j])
				local xx, yy = x * tileDim + tileDim / 2, y * tileDim + tileDim / 2
				if (math.sqrt((xx - hitbox.x2)^2 + (yy - hitbox.y2)^2) < hitbox.rad or
					math.sqrt((xx - hitbox.x )^2 + (yy - hitbox.y )^2) < hitbox.rad) and val > 1 then
					itemList[val].interact(itemList[val])
				end
			end
		end
	end
end

