local ipairs = ipairs
---循环执行一个函数
---@param arr  fun(...)[] @arr
local function localf(arr,...)
	for _,f in ipairs(arr) do
		f(...)
	end
end

return localf