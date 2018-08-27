sfx = {}

function sfx.preload()
	sfx.weow = love.audio.newSource("sfx/weow.wav", "static")
	sfx.realcraft = love.audio.newSource("sfx/realcraft.wav", "static")
	sfx.bg = love.audio.newSource("sfx/background.wav", "static")
	sfx.bg:setLooping(true)
	sfx.bg:play()
	sfx[2] = love.audio.newSource("sfx/bom2.wav", "static")
	sfx[2]:setLooping(true)
	sfx[2]:play()
end

function sfx.effect()
end

function sfx.update()
	sfx[2]:setPitch((math.log(speed + 1.000001) + 1) / 4)
	sfx[2]:setVolume(speed / 10 + 0.1)

	sfx.bg:setVolume(1 - iter.decay / diag)
end

return sfx
