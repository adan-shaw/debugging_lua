local pairs = pairs
---循环执行一个函数
---@param mapf  table<any,fun(...)> @map
local function localf(map,...)
	for k,f in pairs(map) do
		f(...)
	end
end

return localf