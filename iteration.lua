local lg = love.graphics
--debug = require "debug"
Iteration = {id = 0, width = 10, height = 10, decay = 1, field = {}}
Field = {}
Tile = {x, y, state = 1}

--Debug
--[[
function readTable (tab)
for a, b in pairs(tab) do
for c, d in pairs(tab[a]) do
print(tab[a][c].state .. " ")
end
print("\n")
end
end
]]
--End debug


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
	self.field = Field:new(self.width, self.height)
	return self
end

function removeCol (index, target)
	for i = 0, target.height - 1 do
		target.field[index][i] = target.field[index][i] >= 0 and target.field[index][i] * -1 or target.field[index][i]
	end
end

function removeLine (index, target)
	for i = 0, target.width - 1 do
		target.field[i][index] = target.field[i][index] >= 0 and target.field[i][index] * -1 or target.field[i][index]
	end
end

function killTile(iter)
	local x, y = math.random(0, iter.width - 1), math.random(0, iter.height - 1)
	local dx = x * tileDim + tileDim / 2 - W / 2
	local dy = y * tileDim + tileDim / 2 - H / 2
	if math.sqrt(dx^2 + dy^2) > iter.decay and iter.field[x][y] > 0 then
		iter.field[x][y] = -iter.field[x][y]
		return true
	else
		return false
	end
end

function reduceField (currentIter)
	if currentIter.decay > 50 then
		for _ = 0, 30 do
			while not killTile(iter) do end
		end
	else
		local newIter = Iteration:new(currentIter.id - 1, 7, 5, W/2)
		return newIter
	end
	return currentIter
end

function printTable (cible)
	local i, j
	for i = 0, iter.width - 1 do
		for j = 0, iter.height - 1 do
			io.write(iter.field[i][j].state.." ")
		end
		io.write("\n")
	end
	io.write("\n")
end
--[[print("hai")
for k, j in pairs(iter) do
print(k, j)
end]]

--print(iter.field)
--readTable(iter.field)

--[[while iter.id >= -5 do
iter = reduceField(iter)
print("The current field is field n°" .. tostring(iter.id) .. " and its decay is " .. tostring(iter.decay))
if iter.id < -5 then
print("GAME OVER")
end
end]]

