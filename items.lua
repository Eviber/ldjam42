Exit = {x, y, val, locked}

function Exit:new(x, y, val, locked)
	local o = {}
	setmetatable(o, Item)
	self.x = x
	self.y = y
	self.val = val
	self.locked = locked
	return o
end

function Exit:changeLock(status)
	self.locked = status
end

function Exit:goThrough()
	player.health = player.health + 10 > 100 and 100 or player.health + 10
	iter = Iteration:new(iter.id - 1, W / 4, H / 4, 1)
end
	
--HealthPack = {x, y, val}

--function HealthPack:new(x, y, val)