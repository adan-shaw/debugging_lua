local dump = _G.string.dump
local loadstring = _G.loadstring



--简单粗暴的number交换函数
local function f_swap_num(a,b) return b,a; end
api_swap_num = loadstring(dump(f_swap_num))



return {
	swap_num = api_swap_num


}



--测试记录
--[[
	local swap_num = require("def_basic").swap_num
	--测试宏函数
	local x = 999
	local x2 = 111
	print(x, x2)
	x, x2 = swap_num(x, x2)
	print(x, x2)
]]
