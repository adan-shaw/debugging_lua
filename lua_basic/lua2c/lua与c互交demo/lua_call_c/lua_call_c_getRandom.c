//编译:
//		gcc -Wall -fPIC -shared ./lua_call_c_getRandom.c -o ./lua_call_c_getRandom.so 



#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#include "/home/tarball/luajit/include/luajit-2.1/lua.h"
#include "/home/tarball/luajit/include/luajit-2.1/lauxlib.h"
#include "/home/tarball/luajit/include/luajit-2.1/lualib.h"



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



//注册本模块的所有c函数
//const struct luaL_Reg getRandom[] = {
static const luaL_Reg getRandom[] = {
	{"get_xrandom", get_xrandom},
	{"get_x6random", get_x6random},
	{"get_x6random2", get_x6random2},
	{"get_x6random3", get_x6random3},
	{"get_xtime", get_xtime},
	{NULL, NULL}
};

//对外API: 允许lua 机调用本模块的API 注册函数
int luaopen_getRandom(lua_State* L){
	luaL_newlib(L, getRandom);
	return 1;
}





