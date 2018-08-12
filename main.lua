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
	Player = {x = math.random(W-w), y = math.random(H-h), w = w, h = h, health = 100}
  iter = Iteration:new(0, W / 4, H / 4, 1)
  tileDim = math.min(W / iter.width, H / iter.height)
  timeSum = 0
end

function love.draw()
	drawField(iter)
	lg.setColor(0,255,0,255)
	lg.line(Player.x, Player.y, dirx, diry)
	lg.ellipse('fill', Player.x, Player.y, Player.w, Player.h)
	--[[if collision then
		lg.print('COLLISION!!!', W/2, 0)
	end]]
	lg.setColor(1, 0, 0, 1)
	lg.print("Health : "..math.floor(Player.health), 0, 0)
end

function love.update(dt)
	timeSum = timeSum + dt
	posReact(dt)
	if timeSum > 0.5 then
		timeSum = timeSum - 0.5
		iter = reduceField(iter)
    --print("The current field is field n°" .. tostring(iter.id) .. " and its decay is " .. tostring(iter.decay))
	end
	controls.getInput(dt)
end
