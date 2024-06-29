local pairs = pairs

---统计表元素个数
---@param tab table<any,any> @表
---@return count
local function localf(tab)
	local cnt = 0
	for k,v in pairs(tab) do
		cnt = cnt + 1
	end
	return cnt
end

return localf