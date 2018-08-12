local lg = love.graphics

local isDown = love.keyboard.isDown

local controls = require "controls"
local iteration = require "iteration"
local drawIter = require"drawIter"
local playerPos = require "playerPos"
--local debug = require "debug"

function love.load()
	love.window.setMode(1280, 800)
	W, H = lg.getWidth(), lg.getHeight()
	w,h = 5,5
	Player = {x = W/2, y = H/2, w = w, h = h, health = 100}
	iter = Iteration:new(0, W / 8, H / 8, W/2)
	tileDim = math.min(W / iter.width, H / iter.height)
	timeSum = 0
end

function love.draw()
	drawField(iter)
	lg.setColor(0,255,0,255)
	--	lg.circle("line", W/2, H/2, iter.decay)
	lg.line(Player.x, Player.y, dirx, diry)
	lg.ellipse('fill', Player.x, Player.y, Player.w, Player.h)
	--[[if collision then
	lg.print('COLLISION!!!', W/2, 0)
	end]]
	lg.setColor(1, 0, 0, 1)
	lg.print("Health : "..math.floor(Player.health), 0, 0)
end

function love.update(dt)
	posReact(dt)
	iter = reduceField(iter, dt)
	iter.decay = iter.decay - 20 * dt
	controls.getInput(dt)
end
