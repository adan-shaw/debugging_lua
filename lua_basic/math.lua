--lua math 库说明:
--[[
	c 语言math 库有: 整形, 浮点, 复数, 3个版本.
	lua math 库, 只有唯一的double 数据类型, 相当于什么数字都是double.
]]



--lua51 math函数库api 如下:
--[[
	table: 0x41f0a048 {
		ceil				--对1个double向上取整(多出0.1 也会+1)
		floor				--对1个double向下取整(多出0.9 也不会+1)
		modf				--分拆一个数的整形部分and 浮点部分
		fmod				--x 除以 y, 将商向零圆整后的余数.(integer/float)--少用


		abs					--求1个double的绝对值
		min					--求2个double中的最小值
		max					--求2个double中的最大值


		pow					--求M^n
		exp					--自然常数e的x次方
		sqrt				--对1个double开平方
		log					--以自然常数e为低数, 求一个double的对数
		log10				--以10为低数, 求一个double的对数


		sin					--求1个double的正弦值
		cos					--求1个double的余弦值
		tan					--求1个double的正切值
		asin				--求1个double的反正弦值
		acos				--求1个double的反余弦值
		atan				--求1个double的反正切值
		atan2				--
		sinh				--求1个double的双曲正弦值
		cosh				--求1个double的双曲余弦值
		tanh				--求1个double的双曲正切值


		random			--get 一个随机数
		randomseed	--设置random()的随机数种子


		huge				--浮点数HUGE_VAL, 这个数比任何数字值都大
		pi					--返回圆周率: 3.1415926535898


		deg					--对1个double的弧度值, 转角度
		rad					--对1个double的角度值, 转弧度
	}
]]



local function lua_math_test()
	--随机数
	math.randomseed(os.time())
	print(math.random(5,90))

	--分拆一个数的整形部分and 浮点部分
	print(math.modf(65536.12345))

	--取整, 增益权重(多出0.1 也会+1)
	print(math.ceil(8.1))
	print(math.ceil(8.0))
	--取整, 减益权重(多出0.9 也不会+1)
	print(math.floor(8.9))

	--求最大值(可以输入多个值)
	print(math.max(1,2,3,4,5))
	--求最小值
	print(math.min(1,2,3,4,5))

	--求余运算, math.ceil(-2/3)=0, 余数是-2
	print(math.fmod(-2,3))
	--求余运算, math.floor(-2/3)=-1, 余数为1
	print(-2%3)



	--求绝对值
	print(math.abs(-2018.111))

	--求x的y次幂
	print(math.pow(2,16))

	--求e的x次方
	print(math.exp(3))

	--求开根号x
	print(math.sqrt(65536))

	--以x为底, 求对数y
	print(math.log(2,2))

	--以x为底, 求对数y(默认的底=e)
	print(math.log(54.598150033144))



	--圆周率
	print(math.pi)
	--浮点数HUGE_VAL max(lua double 的永恒最大值)
	print(math.huge)

	--求正弦
	print(math.sin(30))
	--求余弦
	print(math.cos(60))
	--求正切
	print(math.tan(45))
	--求反正弦
	print(math.asin(0.5))
	--求反余弦
	print(math.acos(0.5))
	--求反正切
	print(math.atan(1))



	--角度转弧度
	print(math.rad(180))
	--弧度转角度
	print(math.deg(math.pi))

end



--执行自测函数(正常版)
lua_math_test()





