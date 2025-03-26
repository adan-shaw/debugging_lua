--
--1.lua 文件操作
--
--在/tmp/ 创建临时文件, 文件名随机生成(文件名命名格式是: lua_***), 成功只返回文件名!!
tmpfile = os.tmpname()
print(tmpfile)

--改文件名
os.rename(tmpfile,"/tmp/loveyou")

--删除指定文件
os.remove(tmpfile)

--删除所有/tmp/lua_*** 临时生成的文件:
-- find /tmp -maxdepth 1 -name "lua_*" -exec rm {} \;








--
--2.lua io 文件操作
--
--tmpfs
tmpfs = "/home/tarball/tmpfs/"

--标准std io流(对标c++, 全局唯一)
stderr = io.stderr
stdin = io.stdin
stdout = io.stdout

--标准stdout输出
io.write("stdout: io.write()\n")
--print("love you")

--标准stdin录入
--str_tmp = io.read()


--默认情况下, 标准io 类只对stdin, stdout进行操作, 使用下面两个函数可以改变标准io 类的行为:
filepath = tmpfs .. "tmpfile"
--修改标准输入, 导入到filepath(等于键盘输入字符串到文件), 文件不存在则返回错误
--io.input(filepath)
--修改标准输出, 导出到filepath(等于程序stdout输出到文件), 文件不存在则返回错误
--io.output(filepath)



--打开文件(成功返回一个file 类实体)
--[[
  "r":  只读模式(文件不存在则返回错误)[默认参数]
  "r+": 读写模式
  "w":  只写模式(文件不存在则自动创建)
  "w+": 读写模式
  "a":  追加模式(只写)
  "a+": 追加模式(读写)
  "b":  以二进制方式打开文件(某些系统不允许这样做, 所以可能会打开失败)

  "r","r+"          会提示错误, 这两种模式不会自动创建文件
  "a","a+","w","w+" 都会创建文件
  "w","w+"          会立即删除文件内容, 再创建新文件用作读写
]]
filepath = tmpfs .. "tmpfile"
--local ret, errmsg = io.open("./tmpfile", "r")
local fd, errmsg, errno = io.open(filepath, "a+")
if(fd == nil) then
	print(errmsg)
	os.exit()
end


--检查fd 类是否可用, 成功返回file
if(io.type(fd) == "file") then
	print(io.type(fd))
end
--跟type() 检查变量类型不一样!! fd 类的变量类型是: userdata
print(type(fd))


--设置文件的缓冲模式, 有三种模式:
--[[
	"no": 不缓冲, 同步读写
	"full": 完全缓冲, 只有在缓存满, 或当你显式的对文件调用flush(), 才会写盘
	"line": 行缓冲, 每次换行即写入
]]
fd:setvbuf("line")


--写
fd:write("love you\n")


--冲刷
fd:flush()


--移动游标到文件头(注意: 以a/a+ 追加模式打开文件时, 文件游标在EOF, 所以读取数据经常会出错, 需要先调整文件游标)
--[[
	"set": 从文件头开始, 文件游标移动offset 字节
	"cur": 从当前位置开始[默认], 文件游标移动offset 字节
	"end": 从文件尾开始, 文件游标移动offset 字节
	[offset默认为0]
]]
--游标调整到文件尾
--fd:seek("end")
fd:seek("end",0)

--游标调整到文件头
fd:seek("set")
--fd:seek("set",0)


--读
--[[
	"n": 从当前位置读入一个number, 如果该字符不为number则返回nil
	"i": 从当前位置读入一个整形number, 如果该字符不为整形number则返回nil
	"l": 从当前位置读入下一行, 如果下一行为文件尾(EOF)则返回nil, 不连带EOF返回 (默认参数)
	"L": 从当前位置读入下一行, 如果下一行为文件尾(EOF)则连带EOF返回
	"a": 从当前位置开始, 读入整个文件内容[读完之后, 文件游标一定为EOF]
	number : 从当前位置开始, 读入指定字节数, 遇到文件尾(EOF), 则返回nil[一定读够字节数, 读不够则返回nil]
]]
str_tmp = fd:read("n")
print(str_tmp)
str_tmp = fd:read()
--str_tmp = fd:read("l")
print(str_tmp)
str_tmp = fd:read("a")
print(str_tmp)
fd:seek("set")
str_tmp = fd:read(5)
print(str_tmp)


--自动从文件中, 逐行读取
--for line in io.lines("filepath") do
--逐行读取(lines()唯一写法, 不能用while())
for line in fd:lines() do
	print(line)
end


--关闭file
fd:close()


--以更新模式创建&打开一个tmpfile(在程序结束/fd:close()时, 会自动删除对应文件)
fd = io.tmpfile()
print(io.type(fd))
fd:close()



