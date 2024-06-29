local next = next
local ipairs = ipairs

---返回数组最大值
---@param arr number[]
---@return number
local function localf(arr)
	local _,max = next(arr)
	for _, val in ipairs(arr) do
		if max < val then
			max = val
		end
	end
	return max
end

return localf