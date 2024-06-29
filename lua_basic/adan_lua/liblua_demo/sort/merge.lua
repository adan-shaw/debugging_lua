---归并排序
---@param arr   any[]	   @数组
---@param comp  function	@比较方法
---@param left  number	  @开始位置
---@param right number	  @结束位置
---@param help  any[]	   @外部传入数据保存
local function localf(arr,comp,left,right,help)
	if left < right then
		local half = (left + right) // 2
		localf(arr,comp,left,half,help)
		localf(arr,comp,half + 1,right,help)
		
		local i1,i2,i3 = left,half + 1,left;
		while i1 <= half and i2 <= right do
			if not comp(arr[i2],arr[i1]) then
				help[i3] = arr[i1]
				i1 = i1 + 1
			else
				help[i3] = arr[i2]
				i2 = i2 + 1
			end
			i3 = i3 + 1
		end

		while (i1 <= half) do
			help[i3] = arr[i1]
			i3,i1 = i3 + 1,i1 + 1
		end

		while (i2 <= right)	do
			help[i3] = arr[i2]
			i3,i2 = i3 + 1,i2 + 1
		end
		
		for i = left,right do
			arr[i] = help[i]
		end
	end
end

return localf