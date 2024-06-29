--Lua coroutine协程
--[[
	lua coro协程的数据空间划分:
		1.main 线程不可直接访问的独立数据空间:
			* 独立的运行数据堆栈(包含coro协程内的所有local 变量数据, 还有main 线程传递进来的参数, 都在独立空间中存储)
			* 独立的function 函数逻辑块(main 线程不能在外面调用coro 协程内定义的函数)

		2.main 线程可直接访问的数据空间:
			* 独立的lua coro协程info, 包括'协程状态'等数据(即: thread-table)
				[唯一可以被main 线程访问的直接数据, main 线程可以询问一下lua coro协程的执行状态]

		3.coro协程共享的数据:
			* 全局变量
			* gc
			* 全局的lua 协程唤醒resume()/挂起yield()机制

	题外话:
		* coro 协程相当于创建一个可暂停的函数, 有'暂停函数'的需求, 可以试试lua coro协程;
			可节省local 变量压栈出栈, 也是不错的一种方法;
			而且这个coro协程也相当于一个sandbox沙盒, 运行过程中较为安全, 崩溃也不会影响main 进程;

		* 需要只执行一次就退出的coro协程, 可以使用wrap()创建协程比create()更节省, 性能更好;



	coro 协程的状态(statue() 状态, 是返回字符串表示的, 编程时需要做字符串判断):
		* suspended: coro 协程已挂起(暂停, 等待资源, 或者陷入阻塞, 或者sleep())
		* running: coro 协程正在工作
		* dead: coro 协程已结束
		* normal: 它可能指的是当一个协程A唤起另一个协程B时, A变处于的状态;(这个coro 协程状态基本不存在, 不用理会)

	在coro 协程函数中, 一旦函数return 返回, coro 协程随后即进入dead 死亡状态;
	只有主动挂起的协程[主动调用yield()], 才会出现suspended 状态;

	如果协程陷入阻塞, 或者cpu sleep(lua 并没有sleep()函数),
	那么lua 机并不会主动帮你挂起协程, 而是直接跟着陷入阻塞, 这并不是智能的, 这时候coro 协程仍然会是显示running;
]]



--创建普通协程, 返回thread-table(一个特殊table)
--[[
	create()创建协程时, 需要指定固定的执行函数体;
	协程创建后, 不会自动启动, 需要使用resume()唤醒后, 才能执行;
	也可以使用status() 询问执行状态(需要询问协程执行状态的, 则要使用create()创建);
	也可以在resume() && yield() 的时候, 传递参数.
]]
local create = coroutine.create



--无thread-table, 只执行一次就退出的协程, 详情请看: wrap协程demo.lua, 这里不做深入探讨
local wrap = coroutine.wrap



--if当前协程是否挂起, 返回true=running, false=yield[调用C函数的过程中, 没必要询问isyieldable, 没意义]
local isyieldable = coroutine.isyieldable


--if当前协程是否running, 返回true=running, false=yield[调用C函数的过程中, 没必要询问running, 没意义]
local running = coroutine.running


--返回指定协程的状态, 返回running/suspended/normal/dead
--[[
	running: 		协程正在工作[由于lua 是单线程的, 因此, 当检测到status = running, 必定是: 自己检查到自己, 等价于coroutine.running()]
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





