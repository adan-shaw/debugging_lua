--[[
	desc:乱序排序
	auth:Carol Luo
]]

local math = math
---乱序排序
---@param list any[] @排序数组
local function localf(list)
	local len = #list
	for i=1,len do
		local pos = math.random(i,len)
		list[i],list[pos] = list[pos],list[i]
	end
	return list
end

return localf