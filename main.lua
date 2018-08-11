local lg = love.graphics

local controls = require "controls"

function love.load()
	love.window.setMode(1280, 800)
	W, H = lg.getWidth(), lg.getHeight()
	w,h = 5,5
	Cursor = {x = math.random(W-w), y = math.random(H-h), w = w, h = h}
end

function love.draw()
	lg.setColor(0,0,200,255)
	lg.line(Cursor.x, Cursor.y, dirx, diry)
	lg.ellipse('fill', Cursor.x, Cursor.y, Cursor.w, Cursor.h)
	if collision then
		lg.print('COLLISION!!!', W/2, 0)
	end
end

function love.update(dt)
	controls.getInput(dt)
end
