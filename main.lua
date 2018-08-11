local lg = love.graphics

local controls = require "controls"
local iteration = require "iteration"

function love.load()
	love.window.setMode(1280, 800)
	W, H = lg.getWidth(), lg.getHeight()
	w,h = 5,5
	Cursor = {x = math.random(W-w), y = math.random(H-h), w = w, h = h}
  iter = Iteration:new(0, 8, 10, 1)
  tileDim = math.min(W / iter.width, H / iter.height)
  timeSum = 0
end

function love.draw()
  local i, j
  lg.setColor(255, 255, 255, 255)
  for i = 0, iter.width - 1 do
    for j = 0, iter.height - 1 do
      if iter.field[i][j].state ~= 0 then
        lg.rectangle('fill', i * tileDim + (W - iter.width * tileDim) / 2, j * tileDim + (H - iter.height * tileDim) / 2, tileDim, tileDim)
      --[[else
        print("tile ["..i.." "..j.."]")]]
      end
    end
  end
  lg.setColor(0, 2, 10, 255)
  for i = 1, iter.width - 1 do
    lg.rectangle('fill', (i * tileDim) - 1 + (W - iter.width * tileDim) / 2, (H - iter.height * tileDim) / 2, 2, H - (H - iter.height * tileDim))
  end
  for j = 1, iter.height - 1 do
    lg.rectangle('fill', (W - iter.width * tileDim) / 2, (j * tileDim) - 1 + (H - iter.height * tileDim) / 2, W - (W - iter.width * tileDim), 2)
  end
  lg.setColor(255,255,255,255)
	lg.line(Cursor.x, Cursor.y, dirx, diry)
	lg.ellipse('fill', Cursor.x, Cursor.y, Cursor.w, Cursor.h)
	if collision then
		lg.print('COLLISION!!!', W/2, 0)
	end
end

function love.update(dt)
  timeSum = timeSum + dt
  if timeSum > 2 then
    timeSum = timeSum - 2
    iter = reduceField(iter)
    --print("The current field is field n°" .. tostring(iter.id) .. " and its decay is " .. tostring(iter.decay))
  end
	controls.getInput(dt)
end
