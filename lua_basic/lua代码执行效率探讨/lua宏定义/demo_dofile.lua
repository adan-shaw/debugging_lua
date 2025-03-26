*1.dofile() 和loadfile() 的区别:
	dofile(""), 以函数的方式装载lua 文件, 装载过程中必定自动执行一次.
	loadfile(""), 以函数的方式装载lua 文件, 装载过程中不自动执行.
	这两个命令, 可以用来装载lua 命令逻辑, 而不是封装好的lua 函数api.
	装载lua 命令逻辑, 方便引用其它lua 文件.

	ps:
		使用loadfile() 可以模拟c 语言中的宏定义;



*2.dofile("") && loadfile("") 装载*.lua 文件时, 指定的path 需要带*.lua后缀, 这一点与require("")相反.



*3.string.dump() 也可以将string 字符串压缩成chunk 块, 也可以模拟c 语言中的宏定义;
