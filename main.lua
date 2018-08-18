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
require "drawTransi"
require "generate"

function getDist(x, y)
	local dx = x * tileDim + tileDim / 2 - W / 2
	local dy = y * tileDim + tileDim / 2 - H / 2
	return math.sqrt(dx^2 + dy^2)
end

sfx.preload()
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
	transition = nil
	gameOver = false
	uiFont = lg.setNewFont(30)
	lg.setFont(uiFont)
	-------------------
	door = Exit:new(W / (tileDim * 2), H / (tileDim * 2), 2)
	switch1 = Switch:new(80, 80, 5)
	-------------------
	tuto = lg.newImage("tuto.png")
	love.mouse.setVisible(false)
	resetTransi()
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
		drawTransition()
		if transiRad > diag then blur:stop() end
		if transiRad > diag and tileCount >= iter.width * iter.height then
			transition = false
			resetTransi()
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
	lg.circle('fill', (mx - W / 2)/5 + Player.x, (my - H / 2)/5 + Player.y, 5)
	lg.line(Player.x, Player.y, dirx, diry)
	lg.ellipse('fill', Player.x, Player.y, 10, 10)
	lg.setColor(1, 0, 0, 1)
	if iter.id ~= 1 then printHealth() end
	--lg.print("Health : "..math.floor(Player.health), 0, 0)
	--lg.print("Switches left : "..iter.totalSwitches, 0, 15)
	--lg.print("Norm : "..norm, 0, 30)
	lg.print(iter.id, 10, 10)
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
		growTransi(dt)
	elseif gameOver then
		if isDown('space') then
			love.load()
		end
	end
	sfx.update()
end
