---10进制设置
---@param sum number @总值
---@param bit number @1~n
---@param val number @1~9
---@return number
local function localf(sum,bit,val)
	local p = 10^bit
	local a = sum // p * p
	local b = p / 10 * val
	local c = sum % (p // 10)
	return a + b + c
end

return localf