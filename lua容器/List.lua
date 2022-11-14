--[[
	目标是解决:
		频繁插入/删除时, list 的性能问题(只有在频繁增删的情况下有优势)

		不能批量插入/删除

		允许相同的val元素值
--]]



local List = {}

List.__index = List



--创建链表(自己保证元素的一致性, 否则没办法排序)
function List:New( Type )
	local t = {}
	local setmetatable = _G.setmetatable
	if Type ~= "number" and Type ~= "string" and Type ~= "anything" then
		return nil
	end
	setmetatable(t, self)
	t.Type = Type
	t.Len = 0
	t.First = nil
	t.Last = nil
	return t
end

--返回第一个元素
--成功返回节点的val元素值, 失败返回nil
function List:Front()
	local firstNode = self.First
	if nil ~= firstNode then
		return firstNode.val
	else
		return nil
	end
end

--返回最后一个元素
--成功返回节点的val元素值, 失败返回nil
function List:Back()
	local lastNode = self.Last
	if nil ~= lastNode then
		return lastNode.val
	else
		return nil
	end
end

--从List头部插入元素
function List:PushFront( val )
	local Len = self.Len
	local fristNode = self.First
	--创建节点
	local node = { val = val, front = nil, rear = nil }
	--node.front = nil
	if Len <= 0 then
		--第一次插入, First = Last = node
		self.Last = node
	else
		--节点互扣
		node.rear = fristNode
		fristNode.front = node
	end
	self.First = node
	self.Len = Len + 1
end

--从List尾部插入元素
function List:PushBack( val )
	local Len = self.Len
	local lastNode = self.Last
	--创建节点
	local node = { val = val, front = nil, rear = nil }
	--node.rear = nil
	if Len <= 0 then
		--第一次插入, First = Last = node
		self.First = node
	else
		--节点互扣
		node.front = lastNode
		lastNode.rear = node
	end
	self.Last = node
	self.Len = Len + 1
end

--从List头部弹出元素
--成功返回节点的val元素值, 失败返回nil
function List:PopFront()
	local Len = self.Len
	local fristNode = self.First
	local val = nil
	if Len <= 0 then
		return nil
	else
		val = fristNode.val
		if Len == 1 then
			--List已空, 复原
			self.Last = nil
			self.First = nil
			self.Len = 0
		else
			self.First = fristNode.rear
			self.Len = Len - 1
		end
		--强制释放字节资源?
		fristNode.val = nil
		fristNode.front = nil
		fristNode.rear = nil
		return val
	end
end

--从List尾部弹出元素
--成功返回节点的val元素值, 失败返回nil
function List:PopBack()
	local Len = self.Len
	local lastNode = self.Last
	local val = nil
	if Len <= 0 then
		return nil
	else
		val = lastNode.val
		if Len == 1 then
			--List已空, 复原
			self.Last = nil
			self.First = nil
			self.Len = 0
		else
			self.Last = lastNode.front
			self.Len = Len - 1
		end
		--强制释放字节资源?
		lastNode.val = nil
		lastNode.front = nil
		lastNode.rear = nil
		return val
	end
end

--根据val元素值, 查询元素是否存在, 存在则返回'第一个找到的元素'的node节点
--成功返回目标节点node, 失败返回nil
function List:Find( val )
	local Len = self.Len
	local i = 1
	local fristNode = self.First
	for i=1,Len,1 do
		if fristNode.val == val then
			return fristNode
		else
			fristNode = fristNode.rear
		end
	end
	return nil
end

--队列空?
--成功返回true, 失败返回false
function List:Empty()
	local Len = self.Len
	return ((Len <= 0)  and  true  or  false)
end

--返回List长度
function List:Count()
	local Len = self.Len
	return Len
end

--清空
function List:Clear()
	local Len = self.Len
	local i = 1
	local fristNode = self.First
	local tmp = nil
	local Collectgarbage = collectgarbage
	if Len >= 2 then
		for i=1,Len,1 do
			--全部清洗
			tmp = fristNode.rear
			fristNode.val = nil
			fristNode.front = nil
			fristNode.rear = nil
			fristNode = tmp
		end
		--强制执行一次垃圾回收, 清空缓存
		Collectgarbage("collect")
	elseif fristNode ~= nil then
		--Len == 1
		fristNode.val = nil
		fristNode.front = nil
		fristNode.rear = nil
	end
	self.Len = 0
	self.First = nil
	self.Last = nil
end

--根据val 值, 查找与该val 值匹配的'第一个找到的元素', 然后删除
function List:Remove( val )
	local Len = self.Len
	local frontNode, rearNode = nil, nil
	local node = self:Find(val)
	if node ~= nil then
		if Len == 1 then
			--List已空, 复原
			self.Last = nil
			self.First = nil
			self.Len = 0
		else
			--指针初赋值
			frontNode = node.front
			rearNode = node.rear
			--执行删除
			if frontNode ~= nil then
				frontNode.rear = rearNode
			end
			if rearNode ~= nil then
				rearNode.front = frontNode
			end
			self.Len = Len - 1
			--全部清洗
			node.val = nil
			node.front = nil
			node.rear = nil
		end
	end
end

--根据val 值, 查找与该val 值匹配的'第一个找到的元素', 然后在其后一位插入元素
--找不到, 则自动在队尾添加元素
function List:Insert( index_val, val )
	local node_new = { val = val, front = nil, rear = nil }
	local Len = self.Len
	local rearNode = nil
	local node = self:Find(index_val)
	if node ~= nil then
		--指针初赋值
		rearNode = node.rear
		--执行插入
		node.rear = node_new
		if rearNode ~= nil then
			rearNode.front = node_new
		end
		node_new.rear = rearNode
		node_new.front = node
		self.Len = Len + 1
	else
		self:PushBack(val)
	end
end

--对List 进行排序(拆散, 将元素倒入新的table, sort后再倒出)
--直接交换两个节点的元素值即可, 不需要动链表结构!!
--成功返回一个'带有所有元素的有序table', 失败返回nil
--(该函数可以两用: 可以先排序, 然后返回一个'带有所有元素的有序table';
--也可以仅排序, 不要table;
--List转换为table的性能消耗, 和排序是一样的, 可以两用, 尽量两用)
function List:SortEx()
	local Type = self.Type
	local Len = self.Len
	local fristNode = self.First
	local Sort = _G.table.sort
	local i = 1
	local t = {}
	if Type == "anything" or Len <= 1 then
		--非元素统一的List 拒绝排序, 只有一个元素, 拒绝排序
		return nil
	else
		--number or string都行,拆散&并入table后,直接_G.table.sort()进行排序,省事省力,性能也可以
		for i=1,Len,1 do
			t[i] = fristNode.val
			fristNode = fristNode.rear
		end
		--进行排序
		Sort(t)
		--复原fristNode 指针位置
		fristNode = self.First
		--将排序后的数据, 交换到List中
		for i=1,Len,1 do
			fristNode.val = t[i]
			fristNode = fristNode.rear
		end
		return t
	end
end

--仅排序
function List:Sort()
	local Type = self.Type
	local Len = self.Len
	local fristNode = self.First
	local Sort = _G.table.sort
	local i = 1
	local t = {}
	if Type == "anything" or Len <= 1 then
		--非元素统一的List 拒绝排序, 只有一个元素, 拒绝排序
		--return nil
		return
	else
		--number or string都行,拆散&并入table后,直接_G.table.sort()进行排序,省事省力,性能也可以
		for i=1,Len,1 do
			t[i] = fristNode.val
			fristNode = fristNode.rear
		end
		--进行排序
		Sort(t)
		--复原fristNode 指针位置
		fristNode = self.First
		--将排序后的数据, 交换到List中
		for i=1,Len,1 do
			fristNode.val = t[i]
			fristNode = fristNode.rear
		end
		--return t
	end
end

--对List 进行'洗牌乱序'
--成功返回一个带有所有元素的无序table, 失败返回nil
function List:ShuffleEx()
	local Type = self.Type
	local Len = self.Len
	local fristNode = self.First
	local Random = _G.math.random
	local i = 1
	local r1, r2 = 0, 0
	local tmp = nil
	local t = {}
	if Type == "anything" or Len <= 1 then
		--非元素统一的List 拒绝排序, 只有一个元素, 拒绝乱序
		return nil
	else
		--number or string都行,拆散&并入table后,直接_G.table.sort()进行排序,省事省力,性能也可以
		for i=1,Len,1 do
			t[i] = fristNode.val
			fristNode = fristNode.rear
		end
		--进行乱序
		for i=1,Len,1 do
			r1 = Random(1, Len)
			r2 = Random(1, Len)
			tmp = t[r1]
			t[r1] = t[r2]
			t[r2] = tmp
		end
		--复原fristNode 指针位置
		fristNode = self.First
		--将乱序后的数据, 交换到List中
		for i=1,Len,1 do
			fristNode.val = t[i]
			fristNode = fristNode.rear
		end
		return t
	end
end

--仅乱序
function List:Shuffle()
	local Type = self.Type
	local Len = self.Len
	local fristNode = self.First
	local Random = _G.math.random
	local i = 1
	local r1, r2 = 0, 0
	local tmp = nil
	local t = {}
	if Type == "anything" or Len <= 1 then
		--非元素统一的List 拒绝排序, 只有一个元素, 拒绝乱序
		--return nil
		return
	else
		--number or string都行,拆散&并入table后,直接_G.table.sort()进行排序,省事省力,性能也可以
		for i=1,Len,1 do
			t[i] = fristNode.val
			fristNode = fristNode.rear
		end
		--进行乱序
		for i=1,Len,1 do
			r1 = Random(1, Len)
			r2 = Random(1, Len)
			tmp = t[r1]
			t[r1] = t[r2]
			t[r2] = tmp
		end
		--复原fristNode 指针位置
		fristNode = self.First
		--将乱序后的数据, 交换到List中
		for i=1,Len,1 do
			fristNode.val = t[i]
			fristNode = fristNode.rear
		end
		--return t
	end
end

--仅返回一个带有所有元素的无序table
function List:toTable_Only()
	local Len = self.Len
	local fristNode = self.First
	local i = 1
	local t = {}
	for i=1,Len,1 do
		t[i] = fristNode.val
		fristNode = fristNode.rear
	end
	return t
end

--自测函数(不对外公开)
local function Test(t_list_num)
	local i = 0
	local fristNode = nil
	local t = nil
	t_list_num:PushFront(19)
	t_list_num:PushBack(1)
	t_list_num:PushFront(1900)
	t_list_num:PushBack(222)
	t_list_num:PushBack(222)
	print("t_list_num.Len\t=",t_list_num.Len)
	fristNode = t_list_num.First
	for i=1,t_list_num.Len,1 do
		print(fristNode.val)
		fristNode = fristNode.rear
	end
	t_list_num:Shuffle()
	print("t_list_num.Len\t=",t_list_num.Len)
	fristNode = t_list_num.First
	for i=1,t_list_num.Len,1 do
		print(fristNode.val)
		fristNode = fristNode.rear
	end
	t_list_num:Sort()
	print("t_list_num.Len\t=",t_list_num.Len)
	fristNode = t_list_num.First
	for i=1,t_list_num.Len,1 do
		print(fristNode.val)
		fristNode = fristNode.rear
	end
	print(t_list_num:Front())
	print(t_list_num:Back())
	print(t_list_num:Count())
	print(t_list_num:PopFront())
	print(t_list_num:PopBack())
	print(t_list_num:Count())
	print(t_list_num:Empty())
	print("toTable_Only():")
	t = t_list_num:toTable_Only()
	for i=1,#t,1 do
		print(t[i])
	end
	t_list_num:Clear()
	print(t_list_num:Empty())
end

--启动自测
local t_list_num=List:New("number"); if t_list_num ~= nil then Test(t_list_num) end

return List
