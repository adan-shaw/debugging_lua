local type = type
---@type ifNumber
return function(v)
	return 'number' == type(v)
end
