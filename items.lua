Exit = {x, y, val, locked}

sfx = require "sfx"

function Exit:new(x, y, id)
	local o = {}
	setmetatable(o, Exit)
	self.__index = self
	self.x = x
	self.y = y
	self.val = 2
	self.locked = true
	iter.field[x][y] = id
	itemList[id] = self
	return o
end

function Exit:changeLock(status)
	self.__index = self
	self.locked = status
end

function Exit:interact(obj)
	self.__index = self
	Player.health = Player.health + 10 > 100 and 100 or Player.health + 10
	iter = Iteration:new(iter.id - 1, W / 8, H / 8, diag)
	door = Exit:new(W / (tileDim * 2), H / (tileDim * 2) ,2)
end

HealthPack = {x, y, val}

function HealthPack:new(x, y, id)
	local o = {}
	setmetatable(o, HealthPack)
	self.__index = self
	self.x = x
	self.y = y
	self.val = 3
	iter.field[x][y] = id
	itemList[id] = self
	return o
end

function HealthPack:interact(obj)
	self.__index = self
	Player.health = Player.health + 30 > 100 and 100 or Player.health + 30
	iter.field[self.x][self.y] = iter.field[self.x][self.y] / self.val
	sfx["beep"]:play()
end

RealityCrafter = {x, y, id}

function RealityCrafter:new(x, y, id)
	local o = {}
	setmetatable(o, RealityCrafter)
	self.__index = self
	self.x = x
	self.y = y
	self.val = 4
	iter.field[x][y] = id
	itemList[id] = self
	return o
end

function RealityCrafter:interact()
	self.__index = self
	realityBuffer = realityBuffer + 70
	iter.field[self.x][self.y] = iter.field[self.x][self.y] / self.val
end

Switch = {x, y, id}

--[[function Switch:new(x, y, id)
	local o = {}
	setmetatable(o, Switch)
	self.__index = self
	self.x = x
	self.y = y
	self.val = 5
	self.activated = false
	iter.field[x][y] = id
	itemList[id] = self
	return o]]
