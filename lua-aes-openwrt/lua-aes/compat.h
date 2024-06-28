#include <assert.h>
#if LUA_VERSION_NUM < 502
# define luaL_newlib(L,l) (lua_newtable(L), luaL_register(L,NULL,l))
# define luaL_setfuncs(L,l,n) (assert(n==0), luaL_register(L,NULL,l))
# define luaL_newlibtable(L,l)   \
	lua_createtable(L, 0, sizeof(l)/sizeof((l)[0]) - 1)

#define LUAL_NUMSIZES   (sizeof(lua_Integer)*16 + sizeof(lua_Number))
//LUALIB_API void (luaL_checkversion_) (lua_State *L, lua_Number ver, size_t sz);
#define luaL_checkversion(L) 
#endif

