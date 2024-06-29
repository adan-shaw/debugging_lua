local ipairs = ipairs

---数组总和v
---@param arr number[] @数组
---@return number @sum(v)
local function localf(arr)
	local sum = 0
	for _,v in ipairs(arr) do
		sum = sum + v
	end
	return sum
end

return localf