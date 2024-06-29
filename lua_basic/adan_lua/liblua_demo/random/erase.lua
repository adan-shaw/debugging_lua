--[[
	desc:随机删除 
	auth:Carol Luo
]]

local math = math
local table = table

---随机删除
---@param t any[] @集合列表
---@return any
local function localf(t)
	local count = #t
	local index = math.random(1,count)
	t[count],t[index] = t[index],t[count]
	return table.remove(t)
end

return localf