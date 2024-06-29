local math = math
---折半查找函数
---@param arr 	any[] 								@数组
---@param comp 	fun(a:any,b:any):greaterEqualLess 	@比较函数
---@param val 	any 								@查找值
---@return index
local function localf(arr,comp,val)

	local start = 1
	local close = #arr

	while start < close do
		local half = math.floor((start + close) / 2)
		if 1 == comp(arr[half],val) then
			start = half + 1
		elseif -1 == comp(arr[half],val) then
			start = half - 1
		else
			return half
		end
	end
end

return localf