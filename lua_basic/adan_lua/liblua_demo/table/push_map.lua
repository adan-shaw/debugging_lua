local table = table
local pairs = pairs

---添加列表
---@param t     any[]           @数组
---@param map   table<any,any>  @哈希
local function localf(t,lis)
	for _,v in pairs(lis) do
		table.insert(t,v)
	end
end

return localf