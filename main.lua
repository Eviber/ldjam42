local lg = love.graphics

local isDown = love.keyboard.isDown

local controls = require "controls"
local iteration = require "iteration"
local drawIter = require"drawIter"
local playerPos = require "playerPos"
local items = require "items"
--local debug = require "debug"

function love.load()
	love.window.setMode(1280, 800)
	W, H = lg.getWidth(), lg.getHeight()
	diag = math.sqrt((W/2)^2 + (H/2)^2)
	w,h = 5,5
	Player = {x = W/2, y = H/2, w = w, h = h, health = 100}
	iter = Iteration:new(0, W / 8, H / 8, diag)
	tileDim = math.min(W / iter.width, H / iter.height)
	timeSum = 0
	itemList = {}
	realityBuffer = 0
	
	-------------------
	door = Exit:new(W / (tileDim * 2) + 10, H / (tileDim * 2) ,2)
	Exit.changeLock(door, false)
	pack = HealthPack:new(30, 50, 3)
	crafter = RealityCrafter:new(50, 30, 4)
	-------------------
end

function love.draw()
	drawField(iter)
	lg.setColor(0,255,0,255)
	lg.circle("line", W/2, H/2, iter.decay)
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
	reduceField(iter, dt)
	if iter.decay ~= 0 then
		if realityBuffer == 0 then
			iter.decay = iter.decay - 20 * dt
		else
			iter.decay = iter.decay + 20 * dt
			realityBuffer = realityBuffer - 20 * dt < 0 and 0 or realityBuffer - 20 * dt
		end
	end
	if iter.decay < 0 then iter.decay = 0 end
	controls.getInput(dt)
end
