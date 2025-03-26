--
--lua package包引用系统简介:
--
--[[
	*1.自定义包文件pkg_*.lua 中, 必然返回一个lua table(哈希结构), 作为索引.
		 言外之意, require("") 命令, 必然返回一个lua table 类型.



	*2.require("") 命令中, '文件路径'可以由package.path / package.cpath 修改:
			package.path  包含lua 源文件的path;
			package.cpath 包含*.so共享库文件(以lua标准封装的.so可以直接require 引用);
		 '文件名'不能带有.lua/.so 后缀, 例如:
				引用test.lua 文件: 
					local t = require("test")
				引用test.so 文件: 
					local t = require("test")



	*3.require("") 返回类型如果不是table, 是nil / string, 则表示require 执行失败, 会报错;
			出错原因是: 
				找不到文件, 这是一个常见错误;
				请留意: package.path / package.cpath 的路径是否能找到*.lua / *.so / *.dll 文件, 找不到就会报错;



	*4.打印package.path默认路径:
		 print(package.path)
		 print(package.cpath)
		 //io.write(package.path) //触发io 模块打印, 可能会占用io 带宽, 尽量不用
		 //io.write(package.cpath)

		./?.lua;
		/usr/local/share/lua/5.1/?.lua;
		/usr/local/share/lua/5.1/?/init.lua;
		/home/tarball/luajit2.1.0/share/luajit-2.1.0-beta3/?.lua;
		/home/tarball/luajit2.1.0/share/lua/5.1/?.lua;
		/home/tarball/luajit2.1.0/share/lua/5.1/?/init.lua

		# 实际有效的路径, 就是这两个, 而且/home/tarball/luajit2.1.0/share/lua/5.1 还是空的.
		/home/tarball/luajit2.1.0/share/luajit-2.1.0-beta3/?.lua;
		/home/tarball/luajit2.1.0/share/lua/5.1/?.lua;



	*5.修改package.path:
		 package.path = "./adan_lib/?.lua;"..package.path
		 package.cpath = "./adan_lib/?.so;"..package.cpath



	*6.package 其它api
		package.path
		package.cpath
		package.loaded

		package.config
		package.loadlib
		package.preload
		package.searchers
		package.searchpath



	*7.require("") 命令, 必然会执行一次被装载的lua 文件, 并且获取唯一的return table
		 require("") 命令, 主要用内封装lua 函数api 的.



	*8.释放已经装载的package:
		 package.loaded["debug"] = nil
		 package.loaded["adan_lib/pkg_tab_print"] = nil



	*9.require("") 引用lua 函数api 时, 可以只引用一个api, 而不是装载整个api table
		 local tab_print=require("adan_lib/pkg_tab_print").tab_print
		 tab_print("_G")



	*10.lua内建模块, 不需要require(""), 适宜直接引用
		 --local PRINT=require("io").write; --lua内建模块, 不需要require("io")
		 local PRINT=io.write
		 PRINT("fuck you")
]]



--释放debug 内建模块(debug 内建模块可以释放, 其它都不能)
package.loaded["debug"] = nil



--打印lua 库文件搜索路径
print(package.path)
print(package.cpath)



--打印已装载的所有内建模块
local ptab = require("print_tab").print_tab
ptab(package.loaded)



