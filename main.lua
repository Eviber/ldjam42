local lg = love.graphics

local isDown = love.keyboard.isDown

local controls = require "controls"
local iteration = require "iteration"
local sfx = require "sfx"
local drawIter = require"drawIter"
screen = require "shack/shack"
local playerPos = require "playerPos"
local vfx = require "vfx"
local items = require "items"
local drawTransi = require "drawTransi"

function getDist(x, y)
	local dx = x * tileDim + tileDim / 2 - W / 2
	local dy = y * tileDim + tileDim / 2 - H / 2
	return math.sqrt(dx^2 + dy^2)
end

function love.load()
	W, H = lg.getWidth(), lg.getHeight()
	w,h = 5,5
	diag = math.sqrt((W/2)^2 + (H/2)^2)
	Player = {x = W/4, y = H/2, w = w, h = h, health = 100}
	iter = Iteration:new(1, W / 8, H / 8, diag)
	tileDim = math.min(W / iter.width, H / iter.height)
	vfx.load()
	timeSum = 0
	itemList = {}
	p = {}
	realityBuffer = 0
	sfx.preload()
	transition = nil
	gameOver = false
	uiFont = lg.setNewFont(12)
	-------------------
	door = Exit:new(W / (tileDim * 2), H / (tileDim * 2), 2)
	switch1 = Switch:new(80, 80, 5)
	-------------------
	tuto = lg.newImage("tuto.png")
end

transiRad = 0
function love.draw()
	screen:apply()
	if iter.id ~= 1 then
		callColor(colorTab[(iter.id + 0) % 3 + 1])
		lg.rectangle("fill", 0, 0, W, H)
		lg.setColor(1,1,1,1)
		lg.draw(void)
		drawField(iter)
	else
		lg.setColor(1,1,1,1)
		lg.draw(tuto, 0, 0)
	end
	vfx.draw()
	--	lg.circle("line", W/2, H/2, iter.decay)
	if transition == true then
		callColor(colorTab[(iter.id + 2) % 3 + 1])
		lg.circle('fill', W/2, H/2, transiRad)
		if transiRad > H/2 then blur:stop() end
		if transiRad > diag then
			transition = false
			transiRad = 0
			generateIter(iter.id + 1)
			norm = 0
		end
		lg.setColor(1,1,1,1)
		lg.draw(blur)
		lg.draw(smoke)
		callColor(colorTab[(iter.id + 0) % 3 + 1])
		realdx, realdy = 0, 0
		norm = 0
	else
		callColor(colorTab[(iter.id + 2) % 3 + 1])
	end
	lg.line(Player.x, Player.y, dirx, diry)
	lg.ellipse('fill', Player.x, Player.y, 10, 10)
	lg.setColor(1, 0, 0, 1)
	if iter.id ~= 1 then printHealth() end
	--lg.setFont(uiFont)
	--lg.print("Health : "..math.floor(Player.health), 0, 0)
	--lg.print("Switches left : "..iter.totalSwitches, 0, 15)
	--lg.print("Norm : "..norm, 0, 30)
	if gameOver == true then printGameOver() end
end

function love.update(dt)
	vfx.update(dt)
	if not transition and not gameOver then
		posReact(dt)
		if iter.id ~= 1 then reduceField(iter, dt) end
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
	elseif transition then
		transiRad = transiRad + diag * dt / 2
	elseif gameOver then
		if isDown('space') then
			love.load()
		end
	end
	sfx.update()
end
