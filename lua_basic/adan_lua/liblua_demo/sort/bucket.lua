local math = math
local table = table
local ipairs = ipairs
local clear = require("table.clear")
local fminmax = require("array.minmax")

local copy1 = {}
---桶排序
---@param arr number[] @数组
local function localf(arr)
	
	local buckets = clear(copy1)
	local len = #arr
	local min,max = fminmax(arr)

	--桶的初始化
	local capt = 100
	local lack = ((max - min) // capt) + 1
	for i = 1,lack do
		buckets[i] = {}
	end

	---数据分配
	for i, value in ipairs(arr) do
		local bid = ((value - min) // capt) + 1
		table.insert(buckets[bid],value)
	end

	---数据排序
	local id = 1
	for _, bucket in ipairs(buckets) do
		table.sort(bucket)
		for _, value in ipairs(bucket) do
			arr[id] = value
			id = id + 1
		end
	end

	return arr
end

return localf