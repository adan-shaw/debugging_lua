local next = next
local ipairs = ipairs

---返回数组最小值
---@param arr number[]
---@return number
local function localf(arr)
	local _,min = next(arr)
	for _, val in ipairs(arr) do
		if min > val then
			min = val
		end
	end
	return min
end

return localf