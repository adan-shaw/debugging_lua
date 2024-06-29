local table = table
local exist_count = require("table.exist_count")

---数组查找移除
---@param arr any[] 		@数组
---@param val any	  		@移除的值
---@param cnt count 		@移除个数默认值为1
---@param nck boolean 		@不检查
---@return  boolean
local function localf(arr,val,cnt,nck)
	cnt = cnt or 1
	if not nck then
		if not exist_count(arr,val,cnt) then
			return false
		end
	end

	local len = #arr
	--删除数据
	local i = 1
	while arr[i] do
		if cnt > 0 then
			if arr[i] == val then
				table.remove(arr,i)
				cnt = cnt - 1
			else
				i=i+1
			end
		else
			break
		end
	end
	return true
end

return localf