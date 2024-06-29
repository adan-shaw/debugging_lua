---快速排序
---@param arr any[] @数组
---@param comp function @比较函数
---@param left number @开始位置
---@param right number @结束位置
local function localf(arr,comp,left,right,...)
	if left < right then
		local help = left
		for i = left + 1,right do
			if not comp(arr[left],arr[i],...) then
				help = help + 1
				if help ~= i then
					arr[i],arr[help] = arr[help],arr[i]
				end
			end
		end
		--基准点 = arr[left] 纠正基准值
		if help ~= left then
			arr[left],arr[help] = arr[help],arr[left]
		end
		localf(arr,comp,left,help - 1,...)
		localf(arr,comp,help + 1,right,...)
	end
end

return localf