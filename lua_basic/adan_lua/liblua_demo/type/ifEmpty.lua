--[[
	desc:是否空表 
	auth:Carol Luo
]]

local next = next
return function(t)
	return not t or not next(t)
end