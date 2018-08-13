function generateIter(id)
	itemList = {}
	p = {}
	currentId = 3
	local x, y
	local occupied = false
	iter = Iteration:new(iter.id + 1, W / 8, H / 8, diag)
	Exit:new(W / (tileDim * 2), H / (tileDim * 2), 2, 0)
	maxSwitches = iter.id == 2 and 1 or 2
	for i = 0, maxSwitches do
		x = math.random(W/8 - 1)
		y = math.random(H/8 - 1)
		for a, b in pairs(itemList) do
			if b.x == x and b.y == y then
				occupied = true
				break
			end
		end
		if occupied == true then
			i = i - 1
		else
			Switch:new(x, y, currentId)
			currentId = currentId + 1
		end
	end
end

function generateSwitch()
	local x, y
	local occupied = true
	while (occupied == true) do
		print ("wow")
		occupied = false
		x = math.random(W/8 - 1)
		y = math.random(H/8 - 1)
		if getDist(x, y) < iter.decay then
			for a, b in pairs(itemList) do
				if b.x == x and b.y == y then
					occupied = true
					break
				end
			end
			if occupied == false then
				Switch:new(x, y, currentId)
				print ("Switch generated "..currentId)
				currentId = currentId + 1
			end
		else
			occupied = true
		end
	end
end

				
			
