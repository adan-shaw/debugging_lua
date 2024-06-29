--如何手动回收lua 变量所占用的内存?
--答:
--[[
	--变量创建, 占用内存
	local tmp = "abc"

	--强制回收内存(变量赋值为nil, gc 就会回收变量指向的内存)
	tmp = nil

	--变量新赋值
	--当变量旧的内存空间, 能够容纳新的变量需求时, 不会做任何改变, 直接装入新的值; 
	--当变量旧的内存空间, 不足以容纳新的变量需求时, 释放旧的内存空间/申请扩大旧的内存容量, 再装入新的值;
	tmp = "abcdfgls"

	--ps:
		string, table 变量, 是块内存, 会被回收;
		number 变量是最小粒度的变量内存, 基本不会被回收, 除非函数返回, 函数返回会触发自动清栈;
]]



local loadstring = _G.loadstring



--强制gc 执行完整的一次内存回收(默认选项)
local once = loadstring("return collectgarbage()")
--等价于:
--local once = loadstring(return collectgarbage("collect"))
--当setstepmul = 200的时候, 等价于:
--local step = loadstring(return collectgarbage("step",200))


--加速gc 回收垃圾内存的步伐(一次完整的gc 内存回收, 可能有n step, 这里只是提前n step)
--[这样做既可以提高gc回收内存的效率, 也能减少频繁回收gc 内存带来的内存碎片问题]
local step = loadstring("return collectgarbage(\"step\",1)")


--设置gc 全面回收一次的步进, 默认值200(200 表示gc 的回收速度, 是内存分配速度的两倍)
local set_step_max = loadstring("return collectgarbage(\"setstepmul\", 200)")


--设置gc 在完成一次内存回收之后, 等待多长时间, 才开始下一次内存回收;
--当这个值小于等于100的时候, 就代表执行完一个周期之后不会等待, 直接进入下一个周期;
--当这个值为200的时候, 就代表当内存达到上一个周期结束时的两倍的时候, 再进入下一个周期;
local set_pause = loadstring("return collectgarbage(\"setpause\", 200)")


--停止gc
local stop = loadstring("return collectgarbage(\"stop\")")


--重启gc
local restart = loadstring("return collectgarbage(\"restart\")")


--判断gc 是否在工作
local isrunning = loadstring("return collectgarbage(\"isrunning\")")


--返回gc 使用的总内存数(以KB为单位)
local count = loadstring("return collectgarbage(\"count\")")





--推荐配置(设置gc 回收步进max + gc 回收启动的间歇)
if isrunning() then
	set_step_max()
	set_pause()
end

--自我测试
--[[
	once()
	step()
	set_step_max()
	set_pause()
	stop()
	restart()
	print(isrunning())
	print(count())
]]

return {
	once = once,
	step = step,
	set_step_max = set_step_max,
	set_pause = set_pause,
	stop = stop,
	restart = restart,
	isrunning = isrunning,
	count = count
}


