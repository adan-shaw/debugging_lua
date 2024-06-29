---冒泡排序
---@param arr  any[] @数组
---@param comp function  @比较函数
---@param cnt  number  @结束位置
local function localf(arr,comp,cnt)  
	local len = #arr
	if not cnt then
		cnt = len - 1
	elseif cnt > len then
		cnt = len - 1--避免不必呀的循环
	end
	for i = 1,cnt do
		for j = i + 1,len do  
			if comp(arr[j],arr[i]) then  
				arr[i],arr[j] = arr[j],arr[i]
			end
		end
	end
end

return localf