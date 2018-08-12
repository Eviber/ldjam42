local lg = love.graphics

local isDown = love.keyboard.isDown

local controls = require "controls"
local iteration = require "iteration"
local drawIter = require"drawIter"
screen = require "shack/shack"
local playerPos = require "playerPos"

function love.load()
	love.window.setMode(1280, 800)
	W, H = lg.getWidth(), lg.getHeight()
	w,h = 5,5
	diag = math.sqrt((W/2)^2 + (H/2)^2)
	Player = {x = W/2, y = H/2, w = w, h = h, health = 100}
	iter = Iteration:new(0, W / 8, H / 8, diag)
	tileDim = math.min(W / iter.width, H / iter.height)
-- --------------------------------------------------------------
	screen:setDimensions(W, H)
	psystem = lg.newParticleSystem(love.graphics.newImage('pixel.png'))
	psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(200)
	psystem:setSizes(0, 10)
	psystem:setSizeVariation(0)
	psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.
-- --------------------------------------------------------------
	timeSum = 0
end

function love.draw()
	screen:apply()
	drawField(iter)
	lg.setColor(0,255,0,255)
	--	lg.circle("line", W/2, H/2, iter.decay)
	lg.line(Player.x, Player.y, dirx, diry)
	lg.ellipse('fill', Player.x, Player.y, Player.w, Player.h)
	lg.setColor(1, 0, 0, 1)
	lg.print("Health : "..math.floor(Player.health), 0, 0)
	lg.draw(psystem)
end

function love.update(dt)
	screen:update(dt)
	psystem:update(dt)
	psystem:moveTo(Player.x, Player.y)
	posReact(dt)
	iter = reduceField(iter, dt)
	if iter.decay ~= 0 then
		iter.decay = iter.decay - 20 * dt
	end
	if iter.decay < 0 then iter.decay = 0 end
	controls.getInput(dt)
end
