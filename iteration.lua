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
  setmetatable({}, Tile)
  self.x = x
  self.y = y
  self.state = state or self.state
  return self
end

function Field:new (width, height)
  setmetatable({}, Field)
  local i, j 
  for i = 0, (width * 2) - 1 do
    self[i] = {}
    for j = 0, (height * 2) - 1 do
      self[i][j] = Tile:new(i, j, 1)
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
  for i = 0, target.height do
    target.field[index][i].state = 0
    print("Col : Removed tile ["..index.." "..i.."]")
  end
end

function removeLine (index, target)
  for i = 0, target.width do
    target.field[i][index].state = 0
    print("Line : Removed tile ["..i.." "..index.."]")
  end
end
  
function reduceField (currentIter)
  if currentIter.width > currentIter.decay or currentIter.height > currentIter.decay then 
    if currentIter.width > currentIter.decay then
      removeCol(currentIter.decay, currentIter)
      removeCol(currentIter.width * 2 - currentIter.decay, currentIter)
    end
    if currentIter.height > currentIter.decay then
      removeLine(currentIter.decay, currentIter)
      removeLine(currentIter.height * 2 - currentIter.decay, currentIter)
    end
    currentIter.decay = currentIter.decay + 1
    print("Decayed")
  else
    local newIter = Iteration:new(currentIter.id - 1, 7, 5, 1)
    return newIter
  end
  return currentIter
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
