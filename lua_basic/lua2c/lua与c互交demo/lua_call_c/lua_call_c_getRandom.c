//编译:
//手动tarball: 略(未成功)
//		gcc -g3 -lluajit-5.1 -ldl -lm -Wall -fPIC -shared  -I/home/tarball/luajit/include/luajit-2.1/ -L/home/tarball/luajit/lib ./lua_call_c_getRandom.c -o ./getRandom.so

//安装依赖: apt-get install lua5.1 liblua5.1-0 liblua5.1-0-dbg liblua5.1-0-dev 
//		gcc -g3 -llua5.1 -ldl -lm -Wall -fPIC -shared -I/usr/include/lua5.1/ -L/usr/lib ./lua_call_c_getRandom.c -o ./getRandom.so



#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <errno.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>



//获取复杂随机数-无字典
int get_xrandom(lua_State *L){
	unsigned int _clock = clock();//获取CPU 时钟	-- 取4位
	unsigned int _time = time(NULL);//获取时间		-- 取4位
	unsigned int _clock4 = _clock % 10000;
	unsigned int _time4 = _time % 10000;
	unsigned int result = _clock4*_time4%10000000;
	srand(result);//设置随机数种子
	result = rand()%10000000 + result - 7294;
	lua_pushnumber(L, result);
	return 1;
}



//获取复杂随机数-无字典--对6 求余(摇骰子)
int get_x6random(lua_State *L){
	unsigned int _clock = clock();
	unsigned int _time = time(NULL);
	unsigned int _time4 = _time % 10000;
	unsigned int _clock4 = _clock % 10000;
	unsigned int result = _clock4*_time4%10000000;
	srand(result);
	result = rand()%10000000 + result - 7294;

	result = result%6 + 1;//6->1,1->2,2->3,3->4,4->5,5->6
	lua_pushnumber(L, result);
	return 1;
}



//获取复杂随机数-无字典--对6 求余(摇骰子*2)
int get_x6random2(lua_State *L){
	unsigned int _clock = clock();
	unsigned int _time = time(NULL);
	unsigned int _time4 = _time % 10000;
	unsigned int _clock4 = _clock % 10000;
	unsigned int result = _clock4*_time4%10000000;
	srand(result);
	result = rand()%10000000 + result - 7294;
	_clock = rand()%10000000 - 1234;
	result = result%6 + 1;//6->1,1->2,2->3,3->4,4->5,5->6
	_clock = _clock%6 + 1;
	lua_pushnumber(L, result);
	lua_pushnumber(L, _clock);
	return 2;
}



//获取复杂随机数-无字典--对6 求余(摇骰子*3)
int get_x6random3(lua_State *L){
	unsigned int _clock = clock();
	unsigned int _time = time(NULL);
	unsigned int _time4 = _time % 10000;
	unsigned int _clock4 = _clock % 10000;
	unsigned int result = _clock4*_time4%10000000;
	srand(result);
	result = rand()%10000000 + result - 7294;
	_clock = rand()%10000000 - 1234;
	_time4 = rand()%10000000;
	//printf("%d-%d-%d-%d-%d-%d\n",result,_clock,_time4,rand()%10000000,rand()%10000000,rand()%10000000);//for test
	result = result%6 + 1;//6->1,1->2,2->3,3->4,4->5,5->6
	_clock = _clock%6 + 1;
	_time4 = _time4%6 + 1;
	lua_pushnumber(L, result);
	lua_pushnumber(L, _clock);
	lua_pushnumber(L, _time4);
	return 3;
}



//获取一个当前时间的字符串
int get_xtime(lua_State *L){
	char buf[64];
	time_t t = time(NULL);
	struct tm *_tm = localtime(&t);
	snprintf(buf,64,"%s",asctime(_tm));
	lua_pushstring(L, buf);
	return 1;
}



//注册函数的指示结构体luaL_Reg, 为注册函数提供指导, 告诉本模块有多少个c 函数需要提交到lua 机中运行;
//最后一个元素为'哨兵元素', 两个"NULL"用于告诉Lua没有其他的函数需要注册了;
//const struct luaL_Reg getRandom[] = {
static struct luaL_Reg getRandom[] = {
	{"get_xrandom", get_xrandom},
	{"get_x6random", get_x6random},
	{"get_x6random2", get_x6random2},
	{"get_x6random3", get_x6random3},
	{"get_xtime", get_xtime},
	{NULL, NULL}
};

//对外API: 允许lua 机调用本模块的API 注册函数
/*
此函数为lua_call_c 的关键函数, 通过调用它, 来注册所有C库中的函数, 并将它们存储在适当的位置;
此函数的命名规则应遵循:
	*1.使用"luaopen_"作为前缀;
	*2.后缀名将作为"require"的参数;
如:
	*.c 中定义:
		int luaopen_getRandom(lua_State* L);
	*.lua 中调用:
		local tmp = require(getRandom)
	*.so 编译:
		必须编译出./getRandom.so 文件名, 不能做任何修改
*/
int luaopen_getRandom(lua_State* L){
	luaL_newlib(L, getRandom);
	return 1;
}





