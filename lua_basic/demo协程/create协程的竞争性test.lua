--协程锁竞争性测试
local count = 100
local tmp = 0



co1 = coroutine.create(
	function()
		local i=1
		for i=1,count do
			tmp = tmp + 1
			print("co1",tmp)
		end
	end
)

co2 = coroutine.create(
	function()
		local i=1
		for i=1,count do
			tmp = tmp + 1
			print("co2",tmp)
		end
	end
)

co3 = coroutine.create(
	function()
		local i=1
		for i=1,count do
			tmp = tmp + 1
			print("co3",tmp)
		end
		--让lua 机陷入阻塞, 测试当协程陷入阻塞的时候, lua 机会不会主动帮你挂起协程, 
		--答案是: 不会!! 
		--lua 机并不会主动帮你挂起协程, 而是直接跟着陷入阻塞, 这并不是智能的
		os.execute("sleep 5")
	end
)

--lua 协程的特性:
--[[
	lua 携程, 其实就只是相当于一个可以暂停的函数而已(普通函数不可以暂停),
	本质上, lua 就只能是一个单线程程序, 毫无并发可言,
	因此, lua 协程也不会有任何的线程冲突问题, 资源访问冲突问题, 永远单线, 无需加锁;

	即使两个协程对同一个变量操作, 也是先到先得, 谁先到谁操作, 
	直到先到的协程结束or 主动挂起,
	另外一个协程, 才能访问这个变量.
]]

coroutine.resume(co1)
coroutine.resume(co2)
coroutine.resume(co3)


--打印协程的状态
print(coroutine.status(co1))
print(coroutine.status(co2))
print(coroutine.status(co3))


