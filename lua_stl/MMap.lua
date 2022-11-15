--[[
	目标:
		利用linklist + key + value, 实现可以'频繁删除&插入'的mult map(只有在频繁增删的情况下有优势)

		不能批量插入/删除

		允许相同的key键值(即multiple map)
]]



local MMap = {}

MMap.__index = MMap



--创建链表(自己保证元素的一致性, 否则没办法排序)
function MMap:New( keyType )
	local t = {}
	local setmetatable = _G.setmetatable
	if keyType ~= "number" and keyType ~= "string" and keyType ~= "anything" then
		return nil
	end
	setmetatable(t, self)
	t.keyType = keyType
	t.Len = 0
	t.First = nil
	t.Last = nil
	return t
end

--返回第一个元素
--成功返回节点的key+val, 失败返回nil
function MMap:Front()
	local firstNode = self.First
	if nil ~= firstNode then
		return {firstNode.key, firstNode.val}
	else
		return nil
	end
end

--返回最后一个元素
--成功返回节点的key+val, 失败返回nil
function MMap:Back()
	local lastNode = self.Last
	if nil ~= lastNode then
		return {lastNode.key, lastNode.val}
	else
		return nil
	end
end

--从MMap头部插入元素
function MMap:PushFront( key, val )
	local Len = self.Len
	local fristNode = self.First
	--创建节点
	local node = { key = key, val = val, front = nil, rear = nil }
	--node.Front = nil
	if Len <= 0 then
		--第一次插入, Front = Rear = node
		self.Last = node
	else
		--节点互扣
		node.rear = fristNode
		fristNode.front = node
	end
	self.First = node
	self.Len = Len + 1
end

--从MMap尾部插入元素
function MMap:PushBack( key, val )
	local Len = self.Len
	local lastNode = self.Last
	--创建节点
	local node = { key = key, val = val, front = nil, rear = nil }
	--node.Rear = nil
	if Len <= 0 then
		--第一次插入, Front = Rear = node
		self.First = node
	else
		--节点互扣
		node.front = lastNode
		lastNode.rear = node
	end
	self.Last = node
	self.Len = Len + 1
end

--从MMap头部弹出元素
--成功返回节点的val元素值, 失败返回nil
function MMap:PopFront()
	local Len = self.Len
	local fristNode = self.First
	local key, val = nil, nil
	if Len <= 0 then
		return nil
	else
		key = fristNode.key
		val = fristNode.val
		if Len == 1 then
			--MMap已空, 复原
			self.Last = nil
			self.First = nil
			self.Len = 0
		else
			self.First = fristNode.rear
			self.Len = Len - 1
		end
		--强制释放字节资源?
		fristNode.key = nil
		fristNode.val = nil
		fristNode.front = nil
		fristNode.rear = nil
		return {key, val}
	end
end

--从MMap尾部弹出元素
--成功返回节点的val元素值, 失败返回nil
function MMap:PopBack()
	local Len = self.Len
	local lastNode = self.Last
	local key, val = nil, nil
	if Len <= 0 then
		return nil
	else
		key = lastNode.key
		val = lastNode.val
		if Len == 1 then
			--MMap已空, 复原
			self.Last = nil
			self.First = nil
			self.Len = 0
		else
			self.Last = lastNode.front
			self.Len = Len - 1
		end
		--强制释放字节资源?
		lastNode.key = nil
		lastNode.val = nil
		lastNode.front = nil
		lastNode.rear = nil
		return {key, val}
	end
end

--根据key, 查询元素是否存在, 存在则返回'第一个找到的元素'的node节点
--成功返回目标节点node, 失败返回nil
function MMap:Find( key )
	local Len = self.Len
	local i = 1
	local fristNode = self.First
	for i=1,Len,1 do
		if fristNode.key == key then
			return fristNode
			--return {fristNode.key, fristNode.val}
		else
			fristNode = fristNode.rear
		end
	end
	return nil
end

--根据Key, 返回Key所在的tmp table的Pos位置(绝对有问题)
--成功返回'key 节点的pos', 失败返回nil
function MMap:GetKeyPosInTable( Tab, Len, key )
	local i = 0
	for i=1,Len,1 do
		if Tab[i] == key then
			return i
		end
	end
	return nil
end

--队列空?
--成功返回true, 失败返回false
function MMap:Empty()
	local Len = self.Len
	return ((Len <= 0)  and  true  or  false)
end

--返回MMap长度
function MMap:Count()
	local Len = self.Len
	return Len
end

--清空
function MMap:Clear()
	local Len = self.Len
	local i = 1
	local fristNode = self.First
	local tmp = nil
	local Collectgarbage = collectgarbage
	if Len >= 2 then
		for i=1,Len,1 do
			--全部清洗
			tmp = fristNode.rear
			fristNode.key = nil
			fristNode.val = nil
			fristNode.front = nil
			fristNode.rear = nil
			fristNode = tmp
		end
		--强制执行一次垃圾回收, 清空缓存
		Collectgarbage("collect")
	elseif fristNode ~= nil then
		--Len == 1
		fristNode.key = nil
		fristNode.val = nil
		fristNode.front = nil
		fristNode.rear = nil
	end
	self.Len = 0
	self.First = nil
	self.Last = nil
end

--根据key 值, 查找与该key 值匹配的'第一个找到的元素', 然后删除
function MMap:Remove( key )
	local Len = self.Len
	local node = self:Find(key)
	local frontNode, rearNode = nil, nil
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
			node.key = nil
			node.val = nil
			node.Front = nil
			node.Rear = nil
		end
	end
end

--根据key 值, 查找与该key 值匹配的'第一个找到的元素', 然后在其后一位插入元素
--找不到, 则自动在队尾添加元素
function MMap:InsertKey( index_key, key, val )
	local node_new = { key = key, val = val, front = nil, rear = nil }
	local Len = self.Len
	local node = self:Find(index_key)
	local rearNode = nil
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
		self:PushBack(key, val)
	end
end

--仅排序
function MMap:Sort()
	local keyType = self.keyType
	local Len = self.Len
	local fristNode = self.First
	local Sort = _G.table.sort
	local i = 1
	local tk, tv, tkcp = {}, {}, {}
	local pos, ktmp, vtmp = 0, nil, nil
	if keyType == "anything" or Len <= 1 then
		--非元素统一的MMap 拒绝排序, 只有一个元素, 拒绝排序
		return
	else
		--number or string都行,拆散&并入table后,直接_G.table.sort()进行排序,省事省力,性能也可以
		for i=1,Len,1 do
			tk[i] = fristNode.key
			tkcp[i] = fristNode.key
			tv[i] = fristNode.val
			fristNode = fristNode.rear
		end
		--进行排序
		Sort(tkcp)
		--按照tkcp, 重新扫描每一个数据, 错位的纠正
		for i=1,Len,1 do
			pos = self:GetKeyPosInTable(tk, Len, tkcp[i])
			ktmp = tk[pos]
			vtmp = tv[pos]
			tk[pos] = tk[i]
			tv[pos] = tv[i]
			tk[i] = ktmp
			tv[i] = vtmp
		end
		--复原fristNode 指针位置
		fristNode = self.First
		--将排序后的数据, 交换到MMap中(直接对整个list 进行洗牌)
		for i=1,Len,1 do
			fristNode.key = tk[i]
			fristNode.val = tv[i]
			fristNode = fristNode.rear
		end
	end
end

--仅乱序
function MMap:Shuffle()
	local keyType = self.keyType
	local Len = self.Len
	local fristNode = self.First
	local Random = _G.math.random
	local i = 1
	local r1, r2 = 0, 0
	local tmp = nil
	local tk, tv = {}, {}
	if keyType == "anything" or Len <= 1 then
		--非元素统一的MMap 拒绝排序, 只有一个元素, 拒绝乱序
		return
	else
		--number or string都行,拆散&并入table后,直接_G.table.sort()进行排序,省事省力,性能也可以
		for i=1,Len,1 do
			tk[i] = fristNode.key
			tv[i] = fristNode.val
			fristNode = fristNode.rear
		end
		--进行乱序
		for i=1,Len,1 do
			r1 = Random(1, Len)
			r2 = Random(1, Len)
			tmp = tk[r1]
			tk[r1] = tk[r2]
			tk[r2] = tmp
			tmp = tv[r1]
			tv[r1] = tv[r2]
			tv[r2] = tmp
		end
		--复原fristNode 指针位置
		fristNode = self.First
		--将乱序后的数据, 交换到MMap中
		for i=1,Len,1 do
			fristNode.key = tk[i]
			fristNode.val = tv[i]
			fristNode = fristNode.rear
		end
	end
end

--仅返回一个带有所有元素的无序table
function MMap:toTable_Only()
	local Len = self.Len * 2
	local fristNode = self.First
	local i = 1
	local t = {}
	for i=1,Len,2 do
		t[i] = fristNode.key
		t[i+1] = fristNode.val
		fristNode = fristNode.rear
	end
	return t
end

--自测函数(不对外公开)
local function Test(t_map_str)
	local i = 0
	local fristNode = nil
	local t = nil
	t_map_str:PushFront("key", 9)
	t_map_str:PushBack("fff", "ff")
	t_map_str:PushFront("666", "fuc")
	t_map_str:PushBack("qq", "xx")
	t_map_str:InsertKey("fff", "fff", 33333)
	print("t_map_str.Len\t=",t_map_str.Len)
	fristNode = t_map_str.First
	for i=1,t_map_str.Len,1 do
		print(fristNode.key, fristNode.val)
		fristNode = fristNode.rear
	end
	t_map_str:Shuffle()
	print("t_map_str.Len\t=",t_map_str.Len)
	fristNode = t_map_str.First
	for i=1,t_map_str.Len,1 do
		print(fristNode.key, fristNode.val)
		fristNode = fristNode.rear
	end
	t_map_str:Sort()
	print("t_map_str.Len\t=",t_map_str.Len)
	fristNode = t_map_str.First
	for i=1,t_map_str.Len,1 do
		print(fristNode.key, fristNode.val)
		fristNode = fristNode.rear
	end
	print("\n---\n")
	t = t_map_str:Front()
	print(t[1], t[2])
	t = t_map_str:Back()
	print(t[1], t[2])
	print(t_map_str:Count())
	t = t_map_str:PopFront()
	print(t[1], t[2])
	t = t_map_str:PopBack()
	print(t[1], t[2])
	print(t_map_str:Count())
	print(t_map_str:Empty())
	print("toTable_Only():")
	t = t_map_str:toTable_Only()
	for i=1,#t,2 do
		print(t[i],t[i+1])
	end
	t_map_str:Clear()
	print(t_map_str:Empty())
end

--启动自测
local t_map_str=MMap:New("number"); if t_map_str ~= nil then Test(t_map_str) end

return MMap
