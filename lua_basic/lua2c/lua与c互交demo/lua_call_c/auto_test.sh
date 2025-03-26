#!/bin/sh

gcc -Wall -fPIC -shared ./lua_call_c_getRandom.c -o ./lua_call_c_getRandom.so 

lua ./lua_call_c_getRandom.lua
luajit ./lua_call_c_getRandom.lua

rm ./lua_call_c_getRandom.so 
