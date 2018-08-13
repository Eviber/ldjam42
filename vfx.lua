local lg = love.graphics
p = {}

vfx = {}

function vfx.load()
	screen:setDimensions(W, H)
	smoke = lg.newParticleSystem(love.graphics.newImage('pixel.png'))
	smoke:setParticleLifetime(1)
	smoke:setSizes(2, 20)
	smoke:setLinearAcceleration(50, 50, -50, -50)
	smoke:setSizeVariation(0)
	smoke:setColors(0.5, 0.5, 0.5, 1, 0.5, 0.5, 0.5, 0)
end

function vfx.update(dt)
	smoke:setEmissionRate(10 * norm + 1)
	screen:update(dt)
	smoke:update(dt)
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
