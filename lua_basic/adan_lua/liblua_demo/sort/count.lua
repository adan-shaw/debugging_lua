--[[
	desc:计数排序
]]

local ipairs = ipairs
local zero = require("table.zero")
local fmax = require("array.max")
local fmin = require("array.min")
local fminmax = require("array.minmax")

local copy1 = {nil}

---计数排序
---@param arr number[]	 @数组 
---@param min number|nil   @最小
---@param max number|nil   @最大
---@return number[]
local function localf(arr,min,max)

	---默认值
	if not min and not max then
		min,max = fminmax(arr)
	else
		min = min or fmin(arr)
		max = max or fmax(arr)
	end

	---构建桶
	local map = zero(copy1)
	for _, val in ipairs(arr) do
		map[val] = (map[val] or 0) + 1
	end

	---填充表
	local id = 1
	for val = min, max do
		local cnt = map[val]
		if cnt then
			for i = 1, cnt do
				arr[id] = val
				id = id + 1
			end
		end
	end

	return arr
end

return localf