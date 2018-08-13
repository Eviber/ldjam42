function genIter(id)
	itemList = {}
	p = {}
	local x, y
	local occupied = false
	local currentId = 3
	iter = Iteration:new(iter.id + 1, W / 8, H / 8, diag)
	Exit:new(W / (tileDim * 2), H / (tileDim * 2), 2, 0)
	for i = 0, 2 do
		x = math.random(W/2)
		y = math.random(H/2)
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
