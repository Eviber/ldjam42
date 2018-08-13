function voidDamage (dt)
	Player.health = Player.health - dt * 20
end

function healthRegen(dt)
	local tmp = Player.health
	local stock = 0
	local inc = dt * 5
	while tmp > 25 do
		tmp = tmp - 25
		stock = stock + 25
	end
	if tmp + inc > 25 then
		return stock + 25
	else
		return Player.health + inc
	end
end
