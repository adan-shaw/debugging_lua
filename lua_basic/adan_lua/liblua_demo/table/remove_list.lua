local ipairs = ipairs
local find_remove = require("table.find_remove")

---删除列表
---@param t any[] @数组
---@param ... any[] @变长参数
local function localf(t,lis)
	for _,v in ipairs(lis) do
		if not find_remove(t,v) then
			return false
		end
	end
	return true
end


return localf