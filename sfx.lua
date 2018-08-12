sfx = {}

function sfx.preload()
	sfx[0] = love.audio.newSource("sfx/beep.wav", "static")
	sfx[1] = love.audio.newSource("sfx/mgs.mp3", "static")
	sfx[2] = love.audio.newSource("sfx/bom2.wav", "static")
	sfx[2]:setLooping(true)
	sfx[2]:play()
end

function sfx.effect()
end

function sfx.update()
		sfx[2]:setPitch((math.log(norm + 1.000001) + 1) / 4)
		sfx[2]:setVolume(norm / 10 + 0.1)
end

return sfx
