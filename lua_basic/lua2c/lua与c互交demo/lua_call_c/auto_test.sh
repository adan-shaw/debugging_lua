#!/bin/sh

gcc -g3 -llua5.1 -ldl -lm -Wall -fPIC -shared -I/usr/include/lua5.1/ -L/usr/lib ./lua_call_c_getRandom.c -o ./getRandom.so

lua ./lua_call_c_getRandom.lua
luajit ./lua_call_c_getRandom.lua

rm ./getRandom.so 
