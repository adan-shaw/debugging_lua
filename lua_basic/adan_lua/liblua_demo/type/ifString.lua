
local type = type
---@type ifString
return function(v)
	return 'string' == type(v)
end

---@alias ifString fun(v:any):boolean 