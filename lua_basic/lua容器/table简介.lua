--
--1.lua table 容器简介
--
--[[
	lua 可用的数据结构, 只有table一个半成品;

	table 既不是数组, 也不是map 映射红黑树, table 实际上是一个哈希容器, 它具有如下特性:
		table 初始化, 如果不指定元素个数, 默认初始化为4 个值,
			指定初始化n 个元素, 则分配n 个元素的内存空间;


		table 每次插入元素or 删除元素, 只要不是删除最后一个元素, 都会触发哈希重排;
		如果table 的每个元素都独立, 新增/删除后, 不会造成元素缩进的话, 就不会触发哈希重排;
		(可以使用#t 获取table 长度的, 只要新增/删除元素, 都会触发哈希重排, 性能消耗不小)


		table 填满之后, table 会自动增长, 每次增长2^n 次方个元素, 1024 个元素需要拓展10 次;
		最优的初始化分配个数是: 8/16/32/64, 默认最少分配4 个元素


		table 可以像数组一样, 使用下标索引元素, 前提是: key = 连续number数字;
		也可以这样:
				t["loveyou"] = "again"
		或者这样:
				t[1] = "love you"
				t[99] = "again"
		连续number数字为key 的table, 可以使用下面的方式遍历(ipairs()遇到下标不连续的key, 则中断):
			for k,v in ipairs(t) do end
		非连续number数字为key 的table, 可以使用下面的方式遍历(pairs()则不会考虑key的值类型, 直接遍历所有元素):
			for k,v in pairs(t) do end


		table 可以使用#t 来获取'连续number数字的table'的元素个数


	结论:
		你要自己根据table写出各种数据结构, 再编程使用, 
		否则lua 语言, 执行程序的速度极慢, 尤其是逻辑运算, 数据结构方面,(可以用swig 重新封装c++ 容器到lua)
		你也可以使用纯lua 重写数据结构容器, 这样更简洁.
]]





--
--2.lua中table的初始化demo
--
--2.1 创建一个table
local a = {}



--2.2 初始化一个table
local a = {["x"] = 12,["mutou"] = 99,[3] = "hello"}
print(a["x"])



--2.3 初始化一个table(更简洁的方式)
local a = {x=12,mutou=99,[3]="hello"}
print(a["x"])



--2.4 初始化一个table(更简洁的方式) + 更简洁的打印方法
local a = {x=12,mutou=99,[3]="hello"}
print(a.x)




--2.5 定义数字下标索引的连续table
local a ={[1]=12,[2]=43,[3]=45,[4]=90}
--简洁版:
local a = {12,43,45,90}
print(a[1])



--2.6 table 内嵌
local a = {
	{x = 1,y = 2},
	{x = 3,y = 10}
}
print(a[1].x)



--2.7 函数指针下标
function test()
	print("Hello Table")
end
local a = {[1]=test}
--local a = {test}
a[1]()





