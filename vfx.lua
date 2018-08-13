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
	void:setParticleLifetime(1)
	void:setSizes(2)
	void:setLinearAcceleration(5, 5, -5, -5)
	void:setPosition(W/2, H/2)
	void:setEmissionArea("normal", W/2, H/2)
	void:setEmissionRate(500)
end

function vfx.update(dt)
	smoke:setEmissionRate(10 * norm + 1)
	screen:update(dt)
	smoke:update(dt)
	void:update(dt)
	do
		local i = transition and 0 or 2
		local r, g, b = getColor(colorTab[(iter.id + i) % 3 + 1], False)
		void:setColors(r, g, b, 1, r, g, b, 0)
		smoke:setColors(r, g, b, 1, r, g, b, 0)
	end
	for _, psys in pairs(p) do
		psys:update(dt)
	end
	smoke:moveTo(Player.x, Player.y)
end

function vfx.draw()
	lg.setColor(1,1,1,1)
	lg.draw(smoke)
	for _, psys in pairs(p) do
		lg.draw(psys)
	end
end

return vfx
