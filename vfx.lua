local lg = love.graphics

vfx = {}

function vfx.load()
	screen:setDimensions(W, H)
	psystem = lg.newParticleSystem(love.graphics.newImage('pixel.png'))
	psystem:setParticleLifetime(1)
	psystem:setSizes(2, 20)
	psystem:setLinearAcceleration(50, 50, -50, -50)
	psystem:setSizeVariation(0)
	psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0)
end

function vfx.update(dt)
	psystem:setEmissionRate(10 * norm + 1)
	screen:update(dt)
	psystem:update(dt)
	psystem:moveTo(Player.x, Player.y)
end

return vfx
