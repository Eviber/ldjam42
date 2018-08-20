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
	resetTransi()
end

function pyth(x1, y1, x2, y2)
	local dx = x2 - x1
	local dy = y2 - y1
	return math.sqrt(dx^2 + dy^2)
end

function drawPlayerTile(x, y, c)
	local alpha = 4 / pyth(Player.x, Player.y, x + 4, y + 4) + ((math.sin(love.timer.getTime()) / 2 + 0.5) / 40)
	if alpha > 0.1 then
		lg.setColor(c.r, c.g, c.b, alpha)
		lg.rectangle('fill', x, y, 8, 8)
	end
end

function drawPlayer()
	local x = (Player.x) - (Player.x) % 8
	local y = (Player.y) - (Player.y) % 8
	local c = colorTab[(iter.id + 2) % 3 + 1]

	if transition then
		c = colorTab[(iter.id + 0) % 3 + 1]
	end
	lg.setColor(c.r, c.g, c.b, 1)
	lg.rectangle("fill", dirx - 2, diry - 2, 5, 5)

	for i=x-80, x+80, 8 do
		for j=y-80, y+80, 8 do
			drawPlayerTile(i, j, c)
		end
	end
	--drawPlayerTile(x, y , c)
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
		realdx, realdy = 0, 0
		norm = 0
	end
	drawPlayer()
	lg.setColor(1, 0, 0, 1)
	if iter.id ~= 1 then printHealth() end
	lg.print(iter.id, 10, 10)
	if gameOver == true then printGameOver() end
end

function love.update(dt)
	vfx.update(dt)
	if not transition and not gameOver then
		posReact(dt)
		if iter.id ~= 1 then reduceField(iter, dt) end
		if iter.decay ~= 0  and iter.id ~= 1 then
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
		iter.decay = iter.decay + diag * dt / 2
		transiRad = transiRad + diag * dt / 2
		growTransi(dt)
	elseif gameOver then
		if isDown('space') then
			love.event.quit("restart")
		end
	end
	sfx.update()
end
