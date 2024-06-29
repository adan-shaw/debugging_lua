local next = next
local ipairs = ipairs

---返回数组最小值
---@param arr number[]
---@return number,number
local function localf(arr)
	local min,max = next(arr)
	min = max

	for _, val in ipairs(arr) do
		if min > val then
			min = val
		end

		if max < val then
			max = val
		end
	end
	return min,max
end

return localf