---反序排序
---@param list any[] @数组
---@return any[]
local function localf(list)
	local leng = #list
	local half = leng // 2
	for i=1,half do
		local j = leng-i+1
		list[i],list[j] = list[j],list[i]
	end
	return list
end

return localf