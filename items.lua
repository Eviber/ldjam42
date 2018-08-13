Exit = {x, y, val, locked}

sfx = require "sfx"
require "vfx"

function Exit:new(x, y, id)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.x = x
	o.y = y
	o.val = 2
	o.locked = true
	o.id = id
	iter.field[x][y] = id
	itemList[id] = o
	p[id] = love.graphics.newParticleSystem(love.graphics.newImage('pixel.png'))
	p[id]:setParticleLifetime(1)
	p[id]:setSizes(9, 0)
	p[id]:setLinearAcceleration(1, 1, -1, -1)
	p[id]:setColors(0, 0, 1, 1)--, 0, 0, 1, 0)
	p[id]:setEmissionRate(200)
	p[id]:setPosition(x * tileDim + tileDim/2, y * tileDim + tileDim/2)
	p[id]:setTangentialAcceleration(500)
	p[2]:stop()
	return o
end

function Exit:changeLock(status)
	self.__index = self
	self.locked = status
end

function Exit:interact(obj)
	self.__index = self
	if self.locked == false then
		Player.health = Player.health + 10 > 100 and 100 or Player.health + 10
		iter = Iteration:new(iter.id - 1, W / 8, H / 8, diag, 2)
		door = Exit:new(W / (tileDim * 2), H / (tileDim * 2) ,2)
	end
end

HealthPack = {x, y, val}

function HealthPack:new(x, y, id, val)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.x = x
	o.y = y
	o.val = 3
	o.id = id
	iter.field[x][y] = id
	itemList[id] = o
	p[id] = love.graphics.newParticleSystem(love.graphics.newImage('pixel.png'))
	p[id]:setParticleLifetime(0.5)
	p[id]:setSizes(4)
	p[id]:setLinearAcceleration(200, 200, -200, -200)
	p[id]:setColors(0, 1, 0, 1, 0, 1, 0, 0)
	p[id]:setEmissionRate(200)
	p[id]:setPosition(x * tileDim + tileDim/2, y * tileDim + tileDim/2)
	return o
end

function HealthPack:interact(obj)
	self.__index = self
	Player.health = Player.health + 30 > 100 and 100 or Player.health + 30
	iter.field[self.x][self.y] = iter.field[self.x][self.y] / self.val
	sfx["beep"]:play()
	p[self.id]:stop()
end

RealityCrafter = {x, y, id, val}

function RealityCrafter:new(x, y, id)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.x = x
	o.y = y
	o.val = 4
	o.id = id
	iter.field[x][y] = id
	itemList[id] = o
	p[id] = love.graphics.newParticleSystem(love.graphics.newImage('pixel.png'))
	p[id]:setParticleLifetime(0.5)
	p[id]:setSizes(4)
	p[id]:setLinearAcceleration(200, 200, -200, -200)
	p[id]:setColors(0, 1, 1, 1, 0, 1, 1, 0)
	p[id]:setEmissionRate(200)
	p[id]:setPosition(x * tileDim + tileDim/2, y * tileDim + tileDim/2)
	return o
end

function RealityCrafter:interact(obj)
	self.__index = self
	realityBuffer = realityBuffer + 70
	iter.field[self.x][self.y] = iter.field[self.x][self.y] / self.val
	p[self.id]:stop()
end

Switch = {x, y, id, val, activated}
Switch.__index = Switch

function Switch:new(x, y, id)
	local o = {}
	setmetatable(o, self)
	o.__index = self
	o.x = x
	o.y = y
	o.val = 5
	o.activated = false
	o.id = id
	iter.field[x][y] = id
	itemList[id] = o
	p[id] = love.graphics.newParticleSystem(love.graphics.newImage('pixel.png'))
	p[id]:setParticleLifetime(0.5)
	p[id]:setSizes(4)
	p[id]:setLinearAcceleration(200, 200, -200, -200)
	p[id]:setColors(1, 1, 0, 1, 1, 1, 0, 0)
	p[id]:setEmissionRate(200)
	p[id]:setPosition(x * tileDim + tileDim/2, y * tileDim + tileDim/2)
	return o
end

function Switch:interact(obj)
	self.__index = self
	if self.activated == false then
		self.activated = true
		iter.totalSwitches = iter.totalSwitches - 1
		if iter.totalSwitches <= 0 then
			Exit.changeLock(itemList[2], false)
			p[2]:start()
			p[2]:emit(100)
		end
		p[self.id]:stop()
	end
end	
