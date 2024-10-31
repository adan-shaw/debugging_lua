--创建wrap协程简介
--[[
	wrap() 协程是一种只执行一次就自动退出的协程, 非常精简, 没有太多数据冗余, 非常适合只执行一次就退出的任务;
	wrap() 创建时, 需要指定固定的执行函数体;
	wrap() 调用: 创建即自动-启动wrap()协程;

	coroutine.wrap() 函数对标coroutine.create() 函数;

	wrap协程不可做的事:
		* 不可resume()唤醒/yield() 挂起
		* 不可status() 询问执行状态(wrap协程十分精简, 无thread-table(连coro 协程描述Info 都不能查询)
]]


--创建wrap() 协程(创建wrap 协程函数时, 传递参数i 作为打印用的数据)
wrap = coroutine.wrap(
	function(i)
		print(i);
	end
)


--执行wrap() 协程
wrap("love you")


--wrap()协程只能执行一次, 再次执行会报错: cannot resume dead coroutine
wrap(1)
wrap(nil)

