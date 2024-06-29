---删除元素
---@param t table @表数据
---@param k any   @任意数据
---@return V
local function localf(t,k)
	local v = t[k]
	t[k] = nil
	return v
end

return localf