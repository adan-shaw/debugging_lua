local table = table
local select = select

---添加列表(select(i,...) i~最后的所有参数)
---@param t any[] @数组
---@param ... any[] @变长参数
local function localf(t,...)
	for i=1,select("#",...) do
		local v = select(i,...)
		table.insert(t,v)
	end
	return true
end

return localf