local pairs = pairs
---置零数据
---@param t table @表
---@return table
local function localf(t)
	for k,_ in pairs(t) do
		t[k] = 0
	end
	return t
end

return localf