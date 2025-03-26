/*
 * c_call_lua.c
 *
 *  Created on: Sep 23, 2017
 *      Author: adan
 */

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <dirent.h>
#include <errno.h>
#include "../../../extern_lib_install/lua/lua_so/lua534/src/lauxlib.h"
#include "../../../extern_lib_install/lua/lua_so/lua534/src/lua.h"
#include "../../../extern_lib_install/lua/lua_so/lua534/src/lualib.h"

static int l_dir (lua_State * L)
{

	DIR *dir;

	struct dirent *entry;

	int i = 0;

	//如果给定虚拟栈中索引处的元素可以转换为字符串, 则返回转换后的字符串, 否则报错
	const char *path = luaL_checkstring (L, 1);

	//open directory
	dir = opendir (path);

	if (dir == NULL)
	{

		lua_pushnil (L);						//出错返回"nil"
		lua_pushstring (L, strerror (errno));	//加上一个描述错误信息的字符串
		return 2;										//"nil"加上字符串, 共两个返回值...
	}

	//create result table
	lua_newtable (L);

	i = 1;

	while ((entry = readdir (dir)) != NULL)
	{															//逐一读取目录中的文件
		lua_pushnumber (L, i++);		//push key
		lua_pushstring (L, entry->d_name);	//push value
		lua_settable (L, -3);				//t[k] = v
	}

	closedir (dir);								//关闭路径fd
	return 1;											// 返回值只有一个, "table". 
}

//***********************************************************

static int l_sin (lua_State * L)
{

	//如果给定虚拟栈中索引处的元素可以转换为数字, 则返回转换后的数字, 否则报错...
	double d = luaL_checknumber (L, 1);

	lua_pushnumber (L, sin (d));	//压入sin() 函数的结果到lua_stack 中

	//c可以返回给lua 多个结果,通过多次调用lua_push*(), 之后return返回结果的数量, 让lua 自己pop n 次栈

	return 1;											//返回的int 必须>=0, int 表示函数返回的结果的个数
}

int c_call_lua_test (void)
{

	//创建Lua状态机
	lua_State *L = luaL_newstate ();

	//打开Lua状态机"L"中的所有Lua标准库
	luaL_openlibs (L);

	/* 这两句话在lua 机的实验代码中有更简单的方法: lua_register(L, "mysin", l_sin)
	 * 这句话将c 函数"l_sin"定义为lua 的全局变量"mysin", 实现的宏定义如下: 
	 * #define lua_register(L,n,f) \
	 *      (lua_pushcfunction(L, f), lua_setglobal(L, n))
	 */
	//
	lua_pushcfunction (L, l_sin);	//将c 函数转换为lua 的"function"并压入虚拟栈
	lua_setglobal (L, "mysin");		//弹出栈顶元素, 并在lua 中用名为"mysin"的全局变量存储

	//测试mysin
	const char *testfunc = "print(mysin(3.14 / 2))";

	if (luaL_dostring (L, testfunc))	//命令lua 执行lua 命令
		printf ("Failed to invoke.\n");	//失败返回0=NULL=fail !!

	//****************************
	//将c 函数"l_dir"定义为lua 的全局变量"mydir"
	lua_register (L, "mydir", l_dir);

	// 打印"/home/"目录下的所有文件. 
	const char *testfunc2 = "for i, v in pairs(mydir('/home')) do print(i, v) end";

	if (luaL_dostring (L, testfunc2))	//执行Lua命令
		printf ("Failed to invoke.\n");

	lua_close (L);								//关闭Lua状态机

	return 0;

}
