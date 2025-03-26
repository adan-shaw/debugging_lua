//编译:
//手动tarball: 略(未成功)
//		gcc -g3 -lluajit-5.1 -ldl -lm -Wall  -I/home/tarball/luajit/include/luajit-2.1/ -L/home/tarball/luajit/lib ./c_call_lua.c -o ./c_call_lua.exe

//安装依赖: apt-get install lua5.1 liblua5.1-0 liblua5.1-0-dbg liblua5.1-0-dev 
//		gcc -g3 -llua5.1 -ldl -lm -Wall -I/usr/include/lua5.1/ -L/usr/lib ./c_call_lua.c -o ./c_call_lua.exe



#include <stdio.h>
#include <errno.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>



#define LUA_OK (0)//lua5.3 才有的, lua5.1 没有

const char *script = "function my_lua_func(x) return x * 2 end";



//配置'通用的报错宏'的打印API名
#define DEBUG_PRINT_API fprintf

//直接定位到最后一个文件名, 去掉path 前缀(妙啊, 节省字符串)
#define __FILENAME__ (strrchr(__FILE__, '/') ? (strrchr(__FILE__, '/') + 1) : __FILE__)

//报错宏
#define print_debug(...) \
	DEBUG_PRINT_API(stderr, "[%s, %s]%s->%s()->LINE-%d-, errno=[%d], ",\
	__DATE__, __TIME__, __FILE__, __FUNCTION__, __LINE__, errno); \
	printf(__VA_ARGS__);



int main (void)
{
	int tmp;

	//1.创建Lua 状态(首先需要创建一个Lua 状态, 这是Lua 运行时环境的基础)
	lua_State *L = luaL_newstate ();

	luaL_openlibs (L);						//打开lua 的标准库

	//2.加载Lua 脚本(可以通过luaL_dofile() 或luaL_dostring() 等函数加载并执行Lua 脚本)
	if (luaL_dostring (L, script) != LUA_OK)
	{
		print_debug("%s\n", lua_tostring (L, -1));//弹出一个lua 错误(表示错误值已读, 数据没用了, 命令lua 机丢弃该数据, 送进GC 中回收)
		//fprintf (stderr, "Lua script error: %s\n", lua_tostring (L, -1));
		lua_pop (L, 1);
		lua_close (L);
		return -1;
	}
	//luaL_dofile(L, "my_lua_func.lua");//通过*.lua 文件, 获取my_lua_func() 函数

	//3.获取Lua 函数(通过lua_getglobal 获取全局Lua 函数)
	lua_getglobal (L, "my_lua_func");

	//4.调用函数前, 先检查函数是否存在, 以避免运行时错误; 
	if (!lua_isfunction (L, -1))
	{
		print_debug("%s\n", lua_tostring (L, -1));//弹出一个lua 错误
		lua_pop (L, 1);
		lua_close (L);
		return -1;
	}

	//5.调用Lua 函数(使用lua_pcall 调用Lua 函数)
	lua_pushinteger (L, 5);//设置参数为5
	tmp = lua_pcall (L, 1, 1, 0);//1 个参数, 1 个返回值, 0 个错误处理
	if (tmp != LUA_OK)
	{
		print_debug("%s\n", lua_tostring (L, -1));//弹出一个lua 错误
		lua_pop (L, 1);
		lua_close (L);
		return -1;
	}

	//6.处理Lua 函数的返回值
	tmp = lua_tointeger (L, -1);
	printf ("Result of my_lua_func(5) = %d\n", tmp);
	lua_pop (L, 1);//弹出返回值(表示返回值已读, 数据没用了, 命令lua 机丢弃该数据, 送进GC 中回收)

	//7.关闭Lua 状态
	lua_close (L);
	return 0;
}



