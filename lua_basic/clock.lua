local time = _G.os.time
local clock = _G.os.clock
local floor = _G.math.floor



--如何获取纯整形clock()
--[[
	lua默认clock() 返回一个浮点数, 且小于0(有一定几率出现是负数);
	lua默认number 为double, 所以即便使用clock() * 1000000, 也有很大几率返回浮点数,
	因此, 要使用floor()做绝对过滤, 得到纯整形clock();

	lua5.3 才有位操作, lua5.1 基本上不能使用位操作来优化运算;
]]



--返回当前程序使用的CPU 时间的近似值(返回4位整数, 无负数, 无浮点数)
local function get_clockEx4()
	return floor(clock() * 1000000)
end

--返回当前程序使用的CPU 时间的近似值(返回3位整数, 无负数, 无浮点数)
local function get_clockEx3()
	return floor((clock() * 1000000) % 1000)
end

--返回当前程序使用的CPU 时间的近似值(返回2位整数, 无负数, 无浮点数; 随机性更大)
local function get_clockEx2()
	return floor((clock() * 1000000) % 100)
end



--自我测试
--[[
	local n,f=math.modf(get_clockEx4())
	print("get_clockEx4:", n, f)
	local if_num_int = require("if_num_type").if_num_int
	local count = 100000
	local tmp = 0
	while(count > 0) do tmp=get_clockEx4(); if(tmp < 0 or if_num_int(tmp) == false) then print(tmp); end count=count-1; end
	count = 10000000
	tmp = 0
	while(count > 0) do tmp=get_clockEx3(); if(tmp < 0 or if_num_int(tmp) == false) then print(tmp); end count=count-1; end
	count = 10000000
	tmp = 0
	while(count > 0) do tmp=get_clockEx2(); if(tmp < 0 or if_num_int(tmp) == false) then print(tmp); end count=count-1; end
]]



return {
	get_clock = clock,
	get_clockEx2 = get_clockEx2,
	get_clockEx3 = get_clockEx3,
	get_clockEx4 = get_clockEx4
}
