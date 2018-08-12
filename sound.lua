sound = {}

function sound.preload()
	sound.sounds = {}
	sound[0] = love.audio.newSource("sfx/beep.wav", "static")
	sound[1] = love.audio.newSource("sfx/mgs.mp3", "static")
	sound[2] = love.audio.newSource("sfx/bom2.wav", "static")
	sound[2]:setLooping(true)
	sound[2]:play()
end

function sound.effect()
end

function sound.update()
		sound[2]:setPitch(norm / 30 + 1)
		sound[2]:setVolume(norm / 10 + 0.1)
end

return sound
