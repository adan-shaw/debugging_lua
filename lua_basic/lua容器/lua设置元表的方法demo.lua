--lua 设置元表, 需要两个table:
--[[
	第一个table, 是包含所有可索引元素的table(添加类成员, 就在这个table 中添加), 这个table 是类定义, 类声明table;
	第一个table, 还有一个特殊的键__index, __index键一般指向自身的table, 表明第一个table, 可供索引(也叫建立元方法);

	第二个table, 就是一个输出的元表table(这个table的元素可以修改)
	第一个table 的元素可以修改, 修改后, 会自动更新到第二个table 中, 也就是可以动态更新元表;

	面向对象关系:
		第一个table 类似父类, 第二个table 类似子类;
		子类的修改值, 会覆盖父类的修改值, local 优势;
]]



local t_first = {}
local t_second = {}
t_first.__index = t_first
setmetatable(t_second, t_first)

--更新__index索引表
t_first["fuck"] = "fuck you"

--查看__index索引表的更新
print(t_second.fuck)

--测试元表动态更新[ok]
t_first["fuck"] = "fuck you2"
print(t_second.fuck)



--更新元表[ok]
t_second["fuck"] = "FU"

--查看元表的更新
print(t_second.fuck)
