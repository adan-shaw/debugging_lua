---选择排序
---@param arr   any[]     @数组
---@param comp  function  @比较函数
---@param cnt   number    @结束位置
local function localf(arr,comp,cnt)  
	local len = #arr
	if not cnt then
		cnt = len - 1
	elseif cnt > len then
		cnt = len - 1--避免不必要的循环
	end

	local sk
	for i = 1,cnt do
		sk = i
		for j = i + 1,len do  
			if comp(arr[j],arr[sk]) then  
				sk = j
			end
		end
		if sk ~= i then
			arr[i],arr[sk] = arr[sk],arr[i]
		end
	end
end

return localf