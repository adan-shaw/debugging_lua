---10进制获取
---@param sum number @总值
---@param bit number @1~n
---@return number
local function localf(sum,bit)
	local p = 10^bit
	local a = sum // p * p
	local c = sum % (p // 10)
	local b = sum - a - c
	return b / ( p / 10)
end

return localf