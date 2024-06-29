---倒数读取
---@param t any[] @数组
---@param count count @倒数第几
---@return any
local function localf(t,count)
	return t[#t-(count or 0)]
end

return localf