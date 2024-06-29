--指定本lua 文件的lua 解析器的路径
#!/usr/local/bin/luajit
--[[
	在*.lua 脚本的开头, 添加: #!/usr/local/bin/luajit
	就可以让lua 脚本变成python/shell一样, 可以指定固定的lua 运行解析器;
	(脚本的共性, 基本上大部分脚本程序, 都支持这种做法;
	 但不推荐这样做, 因为指定了lua 运行解析器, 就没办法灵活切换lua 运行解析器了;
	 一般情况下, lua 脚本都是: 哪个解析器装载, 就以哪个解析器为准;
	 不过可以生命一下lua 脚本的适用版本: 5.1/5.2/5.3;
	 但暂时没有这么智能, 所以这个功能可以不做)
]]



--相当于system(""), 执行shell 命令; 命令执行结果, 将标准output流用作返回
--(执行后不会终止lua机, 只会返回output流, 得到字符流输出结果)
--(ps: 使用shell 命令来执行find 命令, 还是很好用的; 详细, 你需要自己查看shell 代码库了, 这里不做详述;)
local exec = _G.os.execute

--相当于exit() 函数(会终止lua 虚拟机, 退出进程)
local exit = _G.os.exit




