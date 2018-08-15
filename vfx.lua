local lg = love.graphics
require "drawIter"
require "colorPicker"

p = {}

vfx = {}

function vfx.load()
	screen:setDimensions(W, H)
	smoke = lg.newParticleSystem(love.graphics.newImage('pixel.png'))
	smoke:setParticleLifetime(1)
	smoke:setSizes(2, 20)
	smoke:setLinearAcceleration(50, 50, -50, -50)
	smoke:setSizeVariation(0)

	void = lg.newParticleSystem(love.graphics.newImage('pixel.png'))
	void:setParticleLifetime(2)
	void:setSizes(4)
	void:setLinearAcceleration(10, 10, -10, -10)
	void:setPosition(W/2, H/2)
	void:setEmissionArea("normal", W/2, H/2)
	void:setEmissionRate(150)

	blur = lg.newParticleSystem(love.graphics.newImage('pixel.png'))
	blur:setParticleLifetime(2)
	blur:setSizes(0, 8)
	blur:setPosition(W/2, H/2)
	blur:setLinearAcceleration(1000, 1000, -1000, -1000)
--	blur:setEmissionArea("borderellipse", 0, 0)
	blur:setEmissionRate(300)
	blur:stop()
end

function vfx.update(dt)
	smoke:setEmissionRate(10 * norm + 1)
	screen:update(dt)
	smoke:update(dt)
	void:update(dt)
--	blur:setParticleLifetime(1.75 * transiRad / diag)
--	blur:setEmissionArea("borderellipse", transiRad, transiRad)
	blur:update(dt)
	do
		local i = transition and 0 or 2
		local r, g, b = getColor(colorTab[(iter.id + i) % 3 + 1], False)
		void:setColors(r, g, b, 1, r, g, b, 0)
		smoke:setColors(r, g, b, 1, r, g, b, 0)
		r, g, b = getColor(colorTab[(iter.id + i + 1) % 3 + 1], False)
		blur:setColors(r, g, b, 1)
	end
	for _, psys in pairs(p) do
		psys:update(dt)
	end
	smoke:moveTo(Player.x, Player.y)
end

function vfx.draw()
	lg.setColor(1,1,1,1)
	lg.draw(blur)
	lg.draw(smoke)
	for _, psys in pairs(p) do
		lg.draw(psys)
	end
end

return vfx
