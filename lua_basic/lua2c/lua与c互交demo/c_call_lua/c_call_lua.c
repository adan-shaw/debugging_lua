//编译:
//		gcc -g3 -I/home/tarball/luajit/include/luajit-2.1/ -L/home/tarball/luajit/lib -lluajit-5.1 ./c_call_lua.c -o ./c_call_lua.exe
//		gcc -g3 -I/usr/include/lua5.1/ -L/usr/lib -llua ./c_call_lua.c -o ./c_call_lua.exe



#include <stdio.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"



int main ()
{
	//1.创建 Lua 状态: 首先需要创建一个 Lua 状态, 这是 Lua 运行时环境的基础; 
	lua_State *L = luaL_newstate ();
	luaL_openlibs (L);						//打开标准库

	//2.加载 Lua 脚本: 可以通过 luaL_dofile 或 luaL_dostring 等函数加载并执行 Lua 脚本; 
	const char *script = "function my_lua_function(x) return x * 2 end";
	if (luaL_dostring (L, script) != LUA_OK)
	{
		fprintf (stderr, "Lua script error: %s\n", lua_tostring (L, -1));
		lua_pop (L, 1);
		lua_close (L);
		return -1;
	}

	//3.获取 Lua 函数: 通过 lua_getglobal 获取全局 Lua 函数; 
	lua_getglobal (L, "my_lua_function");

	//4: 检查函数是否存在在调用之前, 检查函数是否存在, 以避免运行时错误; 
	if (!lua_isfunction (L, -1))
	{
		fprintf (stderr, "Error: my_lua_function is not a function\n");
		lua_pop (L, 1);
		lua_close (L);
		return -1;
	}

	//5.调用 Lua 函数: 使用 lua_pcall 调用 Lua 函数; 
	lua_pushinteger (L, 5);				//设置参数为5
	int status = lua_pcall (L, 1, 1, 0);//1 个参数, 1 个返回值, 0 个错误处理
	if (status != LUA_OK)
	{
		fprintf (stderr, "Lua error: %s\n", lua_tostring (L, -1));
		lua_pop (L, 1);
		lua_close (L);
		return -1;
	}

	//6.处理返回值: 处理 Lua 函数的返回值; 
	int result = lua_tointeger (L, -1);
	printf ("Result of my_lua_function(5): %d\n", result);
	lua_pop (L, 1);								//弹出返回值

	//7.关闭 Lua 状态: 完成操作后关闭 Lua 状态; 
	lua_close (L);
	return 0;
}
