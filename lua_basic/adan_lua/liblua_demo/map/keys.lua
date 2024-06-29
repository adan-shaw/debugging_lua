local pairs = pairs
local clear = require("table.clear")
---获取键值列表
---@param 	map	 table<any,count>	@统计表
---@param 	out 	any[]				@外传表
---@return 	any[] @数组表 有重复
local function localf(map,out)
	local arr = clear(out) or {nil}
	local len = 1
	for k,cnt in pairs(map) do
		arr[len] = k
		len = len + 1
	end
	return arr
end

return localf