#!/bin/sh

gcc -g3 -llua5.1 -ldl -lm -fPIC -shared -I/usr/include/lua5.1/ -L/usr/lib ./lua_call_c_getRandom.c -o ./getRandom.so

lua5.1 ./lua_call_c_getRandom.lua
luajit ./lua_call_c_getRandom.lua



# 查看*.so 的API list(看看有没有你的目标函数, 需要添加-g 编译选项才能看到)
:<<!
t和T表示的是符号的类型, 其中:
	t表示的是局部非初始化数据段(Local Uninitialized Data Section),
	T表示的是全局非初始化数据段(Global Uninitialized Data Section);
!
nm ./getRandom.so

rm ./getRandom.so 
