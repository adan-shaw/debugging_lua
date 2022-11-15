--即便lua 宏函数可以用, 也不要急着大规模使用, 用到的时候再决定大规模使用也不迟



--lua 中也可以实现宏定义:
--[[
	单纯使用loadstring()函数, 将string 转换为lua宏定义, 不能解决参数传入的问题;
	没办法传入参数, 也就没有实用意义!!

	因此, lua 中要实现宏定义(或者说, 更类似于'内联函数'), 必须使用两个函数:
		string.dump()
		loadstring()
		[loadstring在从lua5.3开始就被⼲掉了, 直接⽤load即可]

	string.dump():
		负责将lua 函数转换成string 块(包括参数也一起转变)

	loadstring():
		负责将lua 函数string 转换为函数块, 此时type() 从string 转变为function



	lua 宏定义(或者说'内联函数')的优点:
		节省代码(节省代码也是一种优化, 减轻lua 解析器压力, 也减少装载时间)
		减少解析器解析
		减少函数调用, 减少压栈出栈(这个实际上, 可能并没有太大变化)



	lua 宏定义变量引用区域划分:
		宏定义可以引用传入参数
		宏定义可以全局变量
		宏定义不可以引用上下文的local 变量!!
	因此, 务必保证lua 宏定义里面的所有操作, 不要引用local 变量!!
	要引用local 变量, 就要传入lua 宏定义, 或者存入_G全局变量



	如果不使用string.dump(), 会引发错误:
		参数名不能自动适配, 宏函数不能传入参数;
		除非你得保证:
			传入的参数名, 与宏中的参数名一致, 否则得到nil 空值!!



	string.dump()妙用:
		你可以将某个函数, 通过string.dump() 封装成string, 
		然后通过网络传输, 将执行函数的string, 发送到客户端, 
		然后命令client动态执行该函数, 实现动态更新函数.
	前提是:
		client 中存放的变量环境, 参数传入和传出, 需要保持一致, 才能实现这样的功能;
		lua 宏函数, 必须保证所需的参数, 都传入到宏函数中, 或者存入到_G 全局变量中;
--]]



--宏函数引用的参数测试:
--引用local 局部变量(失败)
local val_local = "absbdbsbd"
--引用全局部变量(成功)
val_G = "t1"



--定义宏函数
local function def_test(arg)
  print("it's okay!!")
	print(arg)
	print(val_local)
	print(val_G)
end


--宏函数封装成string
local str_def_test = string.dump(def_test)

--宏函数装载, type() 从string 转变为function
local api_def_test = loadstring(str_def_test)

--执行宏函数
api_def_test("fuck you")

--打印类型
print(type(str_def_test))
print(type(api_def_test))

