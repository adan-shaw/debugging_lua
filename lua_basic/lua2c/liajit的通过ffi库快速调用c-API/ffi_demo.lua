--1.包含ffi 模块
local ffi = require("ffi")



--2.声明: 简单数据类型(不能有特殊数据类型) / 简单c函数API(c函数指针)
--[[
	数据类型支持list: int double char 指针 struct, 不支持类, 不支持特殊数据类型;
									(struct 结构体还要关联metatable 才能创建成功, 很麻烦, 因此一般不创建变量类型);
	c函数API: 				返回普通类型的c函数, 不支持多值函数;
									实在需要用多值函数, 还需要自己伪造: 形参+实参, 很不方便;
]]
ffi.cdef[[
	void sleep(int s);
	int printf(const char *format, int a, int b);
]]



--3.调用简单c函数API
ffi.C.sleep(1)
ffi.C.printf("%d,%d\n",11,99)



--ps: 
--[[
	* 可以考虑用mmap 来快速读取文件;

	* 直接把文件中的字符串, 装载进lua table中, 直接省掉io 读写, 实现内存级返回到客户端, 性能超强;
		缺点:
			每个lua 机都需要消耗一份内存, 当openresty 的线程数量过多时, 消耗较大;
			当项目中的html/css/js 文件, 数量过多时, 消耗过大;
]]
