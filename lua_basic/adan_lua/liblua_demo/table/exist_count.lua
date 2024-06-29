local ipairs = ipairs

---检查数组值个数
---@param arr any[]		@数组
---@param val any		@查值
---@param cnt count		@个数
---@return boolean
local function localf(arr,val,cnt)
	cnt = cnt or 1
	for _,_v in ipairs(arr) do
		if _v == val then
			cnt = cnt - 1
		end
		if cnt <= 0 then
			return true
		end
	end
	return false
end

return localf