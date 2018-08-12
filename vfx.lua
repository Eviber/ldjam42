local lg = love.graphics

vfx = {}

function vfx.load()
	screen:setDimensions(W, H)
	psystem = lg.newParticleSystem(love.graphics.newImage('pixel.png'))
	psystem:setParticleLifetime(1) -- Particles live at least 2s and at most 5s.
	psystem:setSizes(2, 20)
	psystem:setLinearAcceleration(50, 50, -50, -50) -- Random movement in all directions.
	psystem:setSizeVariation(0)
	psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.
end

function vfx.update(dt)
	psystem:setEmissionRate(10 * norm)
	screen:update(dt)
	psystem:update(dt)
	psystem:moveTo(Player.x, Player.y)
end

return vfx
