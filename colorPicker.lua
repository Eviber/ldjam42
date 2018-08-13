local lg = love.graphics

function getColor(color, a)
	a = a == nil and True or a
	if not a then
		return color.r, color.g, color.b
	else
		return color.r, color.g, color.b, color.a
	end
end

function callColor(color)
	lg.setColor(getColor(color))
end
