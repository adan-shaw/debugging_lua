--Lua coroutine协程拥有:
--[[
	独立的堆栈, 独立的局部变量, 独立的function 函数逻辑,
	同时又共享全局变量, gc, lua 协程唤醒/挂起机制.

	相当于创建一个可暂停的函数, 有函数暂停需求的, 可以试试;
	可节省local 变量压栈出栈, 也是不错的一种方法;



	需要询问执行状态的,
	需要在resume() && yield() 的时候, 传递参数,
	可以使用create()创建协程;

	不需要询问执行状态的,
	仅需要一个独立的堆栈, 独立的局部变量的沙盒环境,
	需要只能执行一次的函数(不能重复调用的函数), 
	可以使用wrap()创建协程;
]]



--协程的结束(dead 状态):
--[[
	return 关键字, 可视作协程的彻底结束, 一旦调用return, 即status = dead;
	function 函数结束了, 也是status = dead;

	只有主动挂起的协程, 才会出现suspended 状态;

	如果协程陷入阻塞, 或者cpu sleep(lua 并没有sleep()函数),
	那么lua 机并不会主动帮你挂起协程, 而是直接跟着陷入阻塞, 这并不是智能的
]]





--创建协程, 返回thread-table(一个特殊table)
--[[
	create()创建协程时, 需要指定固定的执行函数体;
	协程创建后, 不会自动启动, 需要使用resume()唤醒后, 才能执行;
	也可以使用status() 询问执行状态(需要询问协程执行状态的, 则要使用create()创建);
	也可以在resume() && yield() 的时候, 传递参数.
]]
local create = coroutine.create



--创建wrap协程, 返回一个函数api指针(跟普通函数一样, 可以直接调用)
--[[
	wrap()创建协程时, 需要指定固定的执行函数体;
	调用wrap()协程函数, 即自动启动wrap()协程;
	[无需resume()唤醒, 
	 只能执行一次, 不能重复调用,
	 也不可以使用status() 询问执行状态, 
	 也不可在resume() && yield() 的时候, 传递参数.]
]]
local wrap = coroutine.wrap



--if当前协程是否挂起, 返回true=running, false=yield[调用C函数的过程中, 没必要询问isyieldable, 没意义]
local isyieldable = coroutine.isyieldable


--if当前协程是否running, 返回true=running, false=yield[调用C函数的过程中, 没必要询问running, 没意义]
local running = coroutine.running


--返回指定协程的状态, 返回running/suspended/normal/dead
--[[
	running: 		协程正在工作[由于lua 是单线程的, 因此, 当检测到status = running,
												 必定是: 自己检查到自己, 等价于coroutine.running()]
	suspended: 	协程已挂起/创建后未启动, 可resume()唤醒
	dead: 			协程已损坏, 不可resume()唤醒
]]
local status = coroutine.status



--唤醒协程, 返回true/false 
--[[
	coroutine.resume()不可能会导致程序崩溃, 它在保护模式下执行的, 可以在任何协程中执行;
	coroutine.resume()可以添加附加参数: 将'附加参数'传递给下一次调用yield的时候, 作为附加返回参数;
	('附加参数'可以为普通变量, 或string.dump()压缩string函数api)
]]
local resume = coroutine.resume


--挂起协程, 返回true/false [调用C函数的过程中, 不能yield 挂起, 否则报错]
local yield = coroutine.yield



