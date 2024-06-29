local select = select
local find_remove = require("table.find_remove")

---删除列表
---@param t any[] @数组
---@param ... any[] @变长参数
local function localf(t,...)
	for i=1,select("#",...) do
		local v = select(i,...)
		if not find_remove(t,v) then
			return false
		end
	end
	return true
end

return localf