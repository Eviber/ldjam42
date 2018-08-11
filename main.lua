local lg = love.graphics

local controls = require "controls"

function love.load()
	W, H = lg.getWidth(), lg.getHeight()
	w,h = 20,20
	Cursor = {x = math.random(W-w), y = math.random(H-h), w = w, h = h}
end

function love.draw()
	lg.setColor(0, 255,0,255)
	lg.rectangle('fill', Cursor.x, Cursor.y, Cursor.w, Cursor.h)
	if collision then
		lg.print('COLLISION!!!', W/2, 0)
	end
end

local isDown = love.keyboard.isDown
function love.update(dt)
	controls.getInput()
end
