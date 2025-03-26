-- 修改lua 搜索*.so 的路径, 防止找不到当前的./lua_call_c_getRandom.so
--package.cpath = "./?.so;./?.dll;" .. package.cpath
print(package.cpath)

--打印lua 的进程工作目录
print(os.getenv("PWD"))

--获取*.lua 执行的相对路径(默认没有办法获取当前的绝对路径, 都是相对路径)
print(arg[0])

--装载.so 共享链接库
local getRandom = require "getRandom"



-- api list
--[[
	//获取复杂随机数-无字典
	int get_xrandom(lua_State *L);

	//获取复杂随机数-无字典--对6 求余(摇骰子)
	int get_x6random(lua_State *L);

	//获取复杂随机数-无字典--对6 求余(摇骰子*2)
	int get_x6random2(lua_State *L);

	//获取复杂随机数-无字典--对6 求余(摇骰子*3)
	int get_x6random3(lua_State *L);

	//获取一个当前时间的字符串
	int get_xtime(lua_State *L);

	//向lua 机注册本模块的所有c函数
	int luaopen_getRandom(lua_State* L);
]]



--测试函数
function test_getRandom()
  local xrandom = getRandom.get_xrandom();
  local x6random = getRandom.get_x6random();
  local xtime = getRandom.get_xtime();
  print(xrandom,x6random,xtime);

  local x62_1,x62_2 = getRandom.get_x6random2();
  print(x62_1,x62_2);

  local x63_1,x63_2,x63_3 = getRandom.get_x6random3();
  print(x63_1,x63_2,x63_3);

  --100w 测试统计...
  print"100w test !!";
  local xstart = os.time();
  local xcount = {0,0,0,0,0,0};
  for i=1,1000000 do
    local tmp = getRandom.get_x6random();--原理都差不多的, 只测试一个了
    if tmp == 1 then
      xcount[1] = xcount[1] + 1;
    elseif tmp == 2 then
      xcount[2] = xcount[2] + 1;
    elseif tmp == 3 then
      xcount[3] = xcount[3] + 1;
    elseif tmp == 4 then
      xcount[4] = xcount[4] + 1;
    elseif tmp == 5 then
      xcount[5] = xcount[5] + 1;
    elseif tmp == 6 then
      xcount[6] = xcount[6] + 1;
    else
      print"unknow error!! return value is not betteen in 1-6"
      break;
    end
  end

  local xend = os.time();
  print("100w test start at:",xstart,"end at",xend);
  print(1,xcount[1]);
  print(2,xcount[2]);
  print(3,xcount[3]);
  print(4,xcount[4]);
  print(5,xcount[5]);
  print(6,xcount[6]);

end

--do test
test_getRandom();



