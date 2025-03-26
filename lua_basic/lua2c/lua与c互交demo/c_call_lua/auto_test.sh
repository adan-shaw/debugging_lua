#!/bin/sh

# 安装依赖: 
#sudo apt-get install lua5.1 liblua5.1-0 liblua5.1-0-dbg liblua5.1-0-dev 

# 编译
gcc -g3 -llua5.1 -ldl -lm -Wall -I/usr/include/lua5.1/ -L/usr/lib ./c_call_lua.c -o ./c_call_lua.exe

# 执行
./c_call_lua.exe
