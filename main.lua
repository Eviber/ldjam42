local lg = love.graphics

local isDown = love.keyboard.isDown

local controls = require "controls"
local iteration = require "iteration"
local drawIter = require"drawIter"
--local debug = require "debug"

function love.load()
	love.window.setMode(1280, 800)
	W, H = lg.getWidth(), lg.getHeight()
	w,h = 5,5
	Cursor = {x = math.random(W-w), y = math.random(H-h), w = w, h = h}
  iter = Iteration:new(0, 9, 11, 1)
  tileDim = math.min(W / iter.width, H / iter.height)
  timeSum = 0
end

function love.draw()
  drawField(iter)
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
