Item = {x, y, val}

function Item:new(x, y, val)
	local o = {}
	setmetatable(o, Item)
	self.x = x
	self.y = y
	self.val = val
	return o
end

Exit = Item.new(