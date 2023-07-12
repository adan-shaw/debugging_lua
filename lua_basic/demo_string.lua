--lua VM对string 的管理机制为:
--[[
	同一个lua vm 中, 同样内容的string, 永远只保留一份copy(lua 机内部自动优化的机制)
	所以, 同一串字符串, 即便有n 个变量赋值&引用, 但实际上, 内存空间中, 也只有一份string 内存空间;
	当这份string 修改时, 才会copy 出去一份(写时复制技术)

	lua自带的string库, 计算字符串长度是以bit来算的, 
	所以一个中文字一般会占用1-4个字节(一般是3bit, 标点符合也是3bit)
	所以没办法统计字符串的字数;
	如果想要统计一个string 有多少字数(单个英文, 单个中文, 都计算为1), 则要引用utf8 库, 安装命令如下:
		luarocks install luautf8
	详情可以参考:
		./lua教程/lua获取utf8(包含中文字)字符串长度.html
]]





--string转换为number(string中存在任何非数字字符, 则出错返回nil)
print(tonumber(nil))
print(tonumber("123"))
print(tonumber("1a1"))


--任意类型转换为string
print(tostring(nil))
print(tostring("123"))
print(tostring("1a1"))


--返回变量的类型: "nil" "number" "string" "boolean" "table" "function" "thread" "userdata"
print(type(nil))
print(type(123))
print(type("1a1"))





--从string中, 按照下标, 取出一个字符, 并自动转换为asc 码
--取第一个字符
print(string.byte("0abcdefg",1))
print(string.char(string.byte("0abcdefg",2)))
--取最后一个字符
print(string.byte("0abcdefg",-1))


--asc 码转换为char[97='a']
print(string.char(97))


--将str 中的大写字母全部转换成小写
print(string.lower("WWcA"))
--将str 中的小写字母转全部换成大写
print(string.upper("aaWSb"))


--获取string长度(英文字母占1bit, 中文占3 bit)
print("len:",string.len(", , , "))
print("len:",string.len("草你妈"))
print("len:",string.len("aa草"))
print("len:",string.len("aa00"))


--string拼接
print("cat1".."cat2")


--re-print 自我打印
print(string.rep("abc", 5))


--string序列反转(反转后变成: cba)
print(string.reverse("abc"))


--string格式化
--[[
	%c - 接受一个数字, 并将其转化为ASCII码表中对应的字符
	%d, %i - 接受一个数字并将其转化为有符号的整数格式
	%o - 接受一个数字并将其转化为八进制数格式
	%u - 接受一个数字并将其转化为无符号整数格式
	%x - 接受一个数字并将其转化为十六进制数格式, 使用小写字母
	%X - 接受一个数字并将其转化为十六进制数格式, 使用大写字母
	%e - 接受一个数字并将其转化为科学记数法格式, 使用小写字母e
	%E - 接受一个数字并将其转化为科学记数法格式, 使用大写字母E
	%f - 接受一个数字并将其转化为浮点数格式
	%g(%G) - 接受一个数字并将其转化为%e(%E, 对应%G)及%f中较短的一种格式
	%q - 接受一个字符串并将其转化为可安全被Lua编译器读入的格式
	%s - 接受一个字符串并按照给定的参数格式化该字符串
]]
print(string.format("i want %d %s", 5, "apples"))





--查找匹配的子string, 命中则返回'第一个匹配的子string'的起始及终点pos下标, 找不到则返回nil
print(string.find("aabc","a"))--1 1
print(string.find("abc","ab"))--1 2
print(string.find("abc","ac"))--nil


--根据下标范围, 提取子string
print(string.sub("abc",1,1))--a
print(string.sub("abc",1,2))--ab
print(string.sub("abc",1,3))--abc



--正则表达式提取子字符串
--^
print(string.match("1abc", "^%d"))  --1
print(string.match("a1bc", "^%d"))  --nil
--$
print(string.match("abc1", "%d$"))  --1
print(string.match("ab1c", "%d$"))  --nil
--+
print(string.match("ab12345ed", "%d+"))  --12345

--print(string.gmatch("aaaa","%a+"))


--正则表达式替换(成功则返回替换的字符数)
--没有参数, 全部替换
print(string.gsub("aaaa","a","d"))
--只替换3 个字符
print(string.gsub("aaaa","a","d",3))
--高级替换用法[环境变量: $HOME and $USER, 格式基本都是: %$(%w+)]
print(string.gsub("home = $HOME, user = $USER", "%$(%w+)", os.getenv))
--高级替换用法2[从table中获取变量, 填充到匹配的string中, 格式基本都是: %$(%w+)]
print(string.gsub("$name-$version.tar.gz", "%$(%w+)", {name="lua", version="5.3"}))







