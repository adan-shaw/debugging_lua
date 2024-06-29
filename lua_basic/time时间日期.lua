local time = _G.os.time
local difftime = _G.os.difftime
local date = _G.os.date



--[[
	--time() 跟c/c++ 中的time() 一样, 返回以s秒为单位的整形秒数(1970年1月1日, 到现在, 即格林尼治时间)
	local time = os.time

	--difftime(), 返回两个time() 的秒数差
	local difftime = os.difftime

	--date() 默认自动代入time()
	local date = os.date
	date("%Y/%m/%d") = date("%Y/%m/%d",os.time())

	--所以编程的时候, 如果需要存储时间变量, 务必一定要存储time() 返回的number,
	--这样一来, 转换工作也十分好做, 直接使用Ex 版本的函数即可.
]]





--返回当前time()转换为date的'年月日'的字符串
local function get_ymd()
	--相当于: print(os.date("%y/%m/%d",os.time()))
	--06/06/22
	return date("%x")
end

--返回当前time()转换为date的'年月日'的字符串
local function get_Ymd()
	--2006/06/22
	return date("%Y/%m/%d")
end

--返回当前time()转换为date的'时分秒'的字符串
local function get_hms()
	--相当于: print(os.date("%H:%M:%S",os.time()))
	--01:04:56
	return date("%X")
end

--返回当前time()转换为date的'年'的string(但可以直接做number数字运算)
local function get_year()
	return date("%Y")
end

--返回当前time()转换为date的'月'的string(但可以直接做number数字运算)
local function get_month()
	return date("%m")
end

--返回当前time()转换为date的'日'的string(但可以直接做number数字运算)
local function get_day()
	return date("%d")
end

--返回当前time()转换为date的'时'的string(但可以直接做number数字运算)
local function get_hour()
	return date("%H")
end

--返回当前time()转换为date的'分'的string(但可以直接做number数字运算)
local function get_minute()
	return date("%M")
end

--返回当前time()转换为date的'秒'的string(但可以直接做number数字运算)
local function get_second()
	return date("%S")
end



--返回传入参数time()转换为date的'年月日'的字符串
local function get_ymdEx(t)
	return date("%x",t)
end

--返回传入参数time()转换为date的'年月日'的字符串
local function get_YmdEx(t)
	return date("%Y/%m/%d",t)
end

--返回传入参数time()转换为date的'时分秒'的字符串
local function get_hmsEx(t)
	return date("%X",t)
end

--返回传入参数time()转换为date的'年'的string(但可以直接做number数字运算)
local function get_yearEx(t)
	return date("%Y",t)
end

--返回传入参数time()转换为date的'月'的string(但可以直接做number数字运算)
local function get_monthEx(t)
	return date("%m",t)
end

--返回传入参数time()转换为date的'日'的string(但可以直接做number数字运算)
local function get_dayEx(t)
	return date("%d",t)
end

--返回传入参数time()转换为date的'时'的string(但可以直接做number数字运算)
local function get_hourEx(t)
	return date("%H",t)
end

--返回传入参数time()转换为date的'分'的string(但可以直接做number数字运算)
local function get_minuteEx(t)
	return date("%M",t)
end

--返回传入参数time()转换为date的'秒'的string(但可以直接做number数字运算)
local function get_secondEx(t)
	return date("%S",t)
end





--自我测试
--[[
	local execute = os.execute
	local t = time()
	execute("sleep 1")
	print("当前time() 系列测试:")
	print(get_ymd())
	print(get_Ymd())
	print(get_hms())
	print(get_year())
	print(get_month())
	print(get_day())
	print(get_hour())
	print(get_minute())
	print(get_second())
	--统一返回string
	print(type(get_ymd()))
	print(type(get_Ymd()))
	print(type(get_hms()))
	print(type(get_year()))
	print(type(get_month()))
	print(type(get_day()))
	print(type(get_hour()))
	print(type(get_minute()))
	print(type(get_second()))
	--对string 字符串进行数值运算(可以直接做运算)
	print(get_hour() + 1000)

	print("Ex系列测试:")
	print(get_ymdEx(t))
	print(get_YmdEx(t))
	print(get_hmsEx(t))
	print(get_yearEx(t))
	print(get_monthEx(t))
	print(get_dayEx(t))
	print(get_hourEx(t))
	print(get_minuteEx(t))
	print(get_secondEx(t))
]]



return {
	time = time,
	difftime = difftime,
	date = date,
	get_ymd = get_ymd,
	get_Ymd = get_Ymd,
	get_hms = get_hms,
	get_year = get_year,
	get_month = get_month,
	get_day = get_day,
	get_hour = get_hour,
	get_minute = get_minute,
	get_second = get_second,
	get_ymdEx = get_ymdEx,
	get_YmdEx = get_YmdEx,
	get_hmsEx = get_hmsEx,
	get_yearEx = get_yearEx,
	get_monthEx = get_monthEx,
	get_dayEx = get_dayEx,
	get_hourEx = get_hourEx,
	get_minuteEx = get_minuteEx,
	get_secondEx = get_secondEx
}
