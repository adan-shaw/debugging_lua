local pairs = pairs

---set求和
---@param set table<number,any> @set
---@return number @sum(k)
local function localf(set)
	local sum = 0
	for k,_ in pairs(set) do
		sum = sum + k
	end
	return sum
end

return localf