local lg = love.graphics
Iteration = {id = 0, width = 10, height = 10, decay = 1, totalSwitches = 0, field = {}}
Field = {}
Tile = {x, y, state = 1}

aDecay = {}

function Tile:new (x, y, state)
	local o = {}
	setmetatable(o, Tile)
	self.x = x
	self.y = y
	self.state = state or self.state
	return o
end

function Field:new (width, height)
	setmetatable({}, Field)
	local i, j 
	for i = 0, width do
		self[i] = {}
		for j = 0, height - 1 do
			self[i][j] = 1--Tile:new(i, j, 1)
		end
	end
	return self
end

function Iteration:new (id, width, height, decay)
	setmetatable({}, Iteration)
	self.id = id
	self.width = width or self.width
	self.height = height or self.height
	self.decay = decay or self.decay
	self.totalSwitches = id
	self.field = Field:new(self.width, self.height)
	return self
end

function killTile(iter)
	local x, y = math.random(0, iter.width - 1), math.random(0, iter.height - 1)
	local dx = x * tileDim + tileDim / 2 - W / 2
	local dy = y * tileDim + tileDim / 2 - H / 2
	if math.sqrt(dx^2 + dy^2) > iter.decay and iter.field[x][y] > 0 then
		iter.field[x][y] = -iter.field[x][y]
		table.insert(aDecay, {x=x, y=y, t=love.timer.getTime()})
		return true
	else
		return false
	end
end

function reduceField (currentIter, dt)
	for _ = 0, 500 * dt do
		local i = 0
		while not killTile(iter) and i < 50 do i = i + 1 end
	end
end
