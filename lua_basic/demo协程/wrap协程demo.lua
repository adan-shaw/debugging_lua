--创建wrap() 协程
wr1 = coroutine.wrap(
	function(i)
		print(i);
	end
)


--执行wrap() 协程
wr1("love you")


--wrap()协程只能执行一次, 再次执行会报错, 因为执行一次之后, 就会dead
wr1(1)
wr1(nil)


