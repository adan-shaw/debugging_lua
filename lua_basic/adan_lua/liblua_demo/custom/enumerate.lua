local upvalue = nil
local hander = function()
	return upvalue
end

---@class enumerate @枚举方法
local this = setmetatable({},{
	__index = function(t,k)
		upvalue = k
		---@type enumHander
		return hander
	end
})

return this