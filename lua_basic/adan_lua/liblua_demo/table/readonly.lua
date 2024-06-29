local assert = assert
local setmetatable = setmetatable

local newindex = function(t,k,v)
	assert(false,"No write permission")
end

---设置一个只读表(嵌套只读表有缺陷)
---@param t  table @数据表
---@return table
local function localf(t)

	local mt = {
	 __index = function(t,k)
		return t[k] 
	 end,

	 __newindex = newindex
	}

	setmetatable(t, mt) 

	return t
end

return localf