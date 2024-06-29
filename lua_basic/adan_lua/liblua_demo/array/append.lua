local table = table
---重复添加
---@param arr any[] @数组
---@param val any   @数据
---@param cnt count @重复
---@return any[]
local function localf(arr,val,cnt)
	for i = 1,cnt do
		table.insert(arr,val)
	end
	return arr
end