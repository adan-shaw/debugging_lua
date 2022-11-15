--本节无使用价值, 很少用



local assert = _G.assert
local error = _G.error
local pcall = _G.pcall



--assert函数(Debug模式下才有效, 少用): 条件出错则终止程序运行, 条件正确则继续程序运行
if assert(true, "assert passed") then print("go on"); end
--if assert(false, "assert error, stop") then print("stop"); end



--error函数: 一旦调用, 则终止当前函数运行, 向上一级返回
--if error("error, stop") then print("stop"); end



--pcall函数: 条件出错, 也会继续在当前函数中运行下去(不可阻挡, 出错就跳过, 继续执行)
if pcall(true, "pcall passed") then
	print("go on")
end

if pcall(false, "pcall error, stop") then
	print("get though it")
end



--自我测试
--print("get though okay !!")



return {
	assert = assert,
	error = error,
	pcall = pcall
}
