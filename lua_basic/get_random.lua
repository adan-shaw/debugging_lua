--lua api 前置解析
local random = _G.math.random
local randomseed = _G.math.randomseed
local time = _G.os.time
local clock = _G.os.clock



--上一次随机数记录器
--[[
	类似于c++的static变量的用法,专门记录上一次随机数;
	装载本lua文件时, 自动初始化,
	后续每次调用本lua文件的函数, 都将自动更新rand_static随机数记录器;
]]
local rand_static = time() * clock()



--随机数的数值范围(只取c语言int的最大值32bit, lua double 64bit, 数值太大了)
local rand_max = 2147483647
local rand_min = -2147483647



--[有负数, 但无浮点数]
local function get_rand()
	--如果时间种子一直不变动, 随机数在1 秒内是不会变动的,
	--所以, 记录上一次的随机数, 加入到下一次random中;
	randomseed(time() * clock() + rand_static)
	rand_static = random(rand_min, rand_max)
	return rand_static
end

--[无负数, 无浮点数]
local function get_randEx()
	randomseed(time() * clock() + rand_static)
	rand_static = random(0, rand_max)
	return rand_static
end



--自我测试(测试时, 第一个数值相同, 可能性很大, 手速过快的话, 但后续的数值一定不会相同!! 放心)
--[[
	--测试get_rand() 是否返回浮点数(通过千万级测试, 绝无浮点数)
	local if_num_int = require("if_num_type").if_num_int
	local count = 10000000
	local tmp = 0
	while(count > 0) do tmp=get_rand(); if(if_num_int(tmp) == false) then print(tmp); end count=count-1; end

	--测试get_randEx() 是否有负数(通过千万级测试, 绝无负数)
	count = 10000000
	tmp = 0
	while(count > 0) do tmp=get_randEx(); if(tmp < 0 or if_num_int(tmp) == false) then print(tmp); end count=count-1; end
]]


return {
	get_rand = get_rand,
	get_randEx = get_randEx,
	rand_max = rand_max,
	rand_min = rand_min
}
