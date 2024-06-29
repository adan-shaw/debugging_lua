local pairs = pairs
---遍历查找
---@param arr 数组
---@param val 查找值
---@return any
local function localf(t,val)
	for key,value in pairs(t) do
		if value == val then
			return key
		end
	end
end

return localf