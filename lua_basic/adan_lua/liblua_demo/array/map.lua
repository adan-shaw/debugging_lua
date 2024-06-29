local ipairs = ipairs
local clear = require("table.clear")

---统计映射
---@param arr any[] @数组
---@param out table @引用
---@return table<any,count>
local function localf(arr,out)
	local map = clear(out) or {}
	for _,v in ipairs(arr) do
		map[v] = (map[v] or 0) + 1
	end
	return map
end

return localf