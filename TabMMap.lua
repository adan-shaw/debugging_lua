--[[
	说明:
		在TabList 的基础上, 改造出TabMMap, 
		元素少的情况下, 也可以适当频繁插入/删除(最好就不要频繁插入/删除)

		可以批量插入元素, 可以批量导出元素

		允许相同的key键值
--]]



local TabMMap = {}

TabMMap.__index = TabMMap

--创建map(keyType = number/string/anything)
--成功返回table, 失败返回nil
--[自己保证元素的一致性, 否则没办法排序]
function TabMMap:New( keyType )
	local t = {}
	local setmetatable = _G.setmetatable
	if keyType ~= "number" and keyType ~= "string" and keyType ~= "anything" then
		return nil
	end
	setmetatable(t, self)
	t.keyType = keyType
	t.Len = 0
	t.Key = {}
	t.Val = {}
	return t
end

--查看队头元素(不操作, 只查看)
--成功返回'Front节点', 失败返回nil
function TabMMap:Front()
	local Len = self.Len
	local Key = self.Key
	local Val = self.Val
	return ((Len <= 0)  and  nil  or  {Key[1],Val[1]})
end

--查看队尾元素(不操作, 只查看)
--成功返回'Back节点', 失败返回nil
function TabMMap:Back()
	local Len = self.Len
	local Key = self.Key
	local Val = self.Val
	return ((Len <= 0)  and  nil  or  {Key[Len],Val[Len]})
end

--从Back队尾插入
--成功返回true, 失败返回false(debug only)
function TabMMap:PushBack( key, val )
	local Len = self.Len + 1
	local Key = self.Key
	local Val = self.Val
	--debug 时开启, 关掉性能更好
	--[[
	local keyType = self.keyType
	local val_keyType = keyType(val)
	if val_keyType ~= keyType and keyType ~= "anything" then
		return false
	end
	--]]
	--更新Len
	self.Len = Len
	Key[Len] = key
	Val[Len] = val
	--return true
end

--从Back队尾弹出
--成功返回'Back节点', 失败返回nil
function TabMMap:PopBack()
	local Len = self.Len
	local Key = self.Key
	local Val = self.Val
	if Len <= 0 then
		return nil
	else
		--更新Len
		self.Len = Len - 1
		return {Key[Len],Val[Len]}
	end
end

--从Front队头插入
--成功返回true, 失败返回false(debug only)
function TabMMap:PushFront( key, val )
	local Insert = _G.table.insert
	local Len = self.Len + 1
	local Key = self.Key
	local Val = self.Val
	--debug 时开启, 关掉性能更好
	--[[
	local keyType = self.keyType
	local val_keyType = keyType(val)
	if val_keyType ~= keyType and keyType ~= "anything" then
		return false
	end
	--]]
	--更新Len
	self.Len = Len
	Insert(Key, 1, key)
	Insert(Val, 1, val)
	--return true
end

--从Front队头弹出
--成功返回'Front节点', 失败返回nil
function TabMMap:PopFront()
	local Len = self.Len
	local ret = nil
	local Remove = _G.table.remove
	local Key = self.Key
	local Val = self.Val
	if Len <= 0 then
		return nil
	else
		ret = {Key[1],Val[1]}
		Remove(Key, 1)
		Remove(Val, 1)
		--更新Len
		self.Len = Len - 1
		return ret
	end
end

--栈空?
--成功返回true, 失败返回false
function TabMMap:Empty()
	local Len = self.Len
	return ((Len <= 0)  and  true  or  false)
end

--返回栈当前元素的长度
function TabMMap:Count()
	local Len = self.Len
	return Len
end

--清空(重置)
function TabMMap:Clear()
	self.Key = {}
	self.Val = {}
	self.Len = 0
end

--交换元素
function TabMMap:Swap(x,y)
	local Key = self.Key
	local Val = self.Val
	local ktmp = Key[x]
	local vtmp = Val[x]
	Key[x] = Key[y]
	Val[x] = Val[y]
	Key[y] = ktmp
	Val[y] = vtmp
end

--重新排序, 打乱TabMMap 原来的顺序[先进先出TabMMap禁用](直接使用_G.table.sort()进行排序)
function TabMMap:Sort()
	local Type = self.Type
	local Len = self.Len
	local Key = self.Key
	local Val = self.Val
	local Sort = _G.table.sort
	local cpKey = {}
	local i = 0
	local pos = 0
	if Type == "anything"  or Len <= 1 then
		return
	end
	--拷贝key
	for i=1,Len,1 do
		cpKey[i] = Key[i]
	end
	--对cpKey进行排序
	Sort(cpKey)
	--按照cpKey, 重新扫描每一个数据, 错位的纠正
	for i=1,Len,1 do
		pos = self:GetKeyPos(cpKey[i])
		self:Swap(i,pos)
	end
end

--洗牌乱序, 打乱TabMMap 原来的顺序, 随机排序(anything 也可以乱序)
function TabMMap:Shuffle()
	local Len = self.Len
	local Key = self.Key
	local Val = self.Val
	local Random = _G.math.random
	local i = 1
	--n 个元素, 乱序n 次(不够乱, 可以增加乱序次数)
	local r1, r2 = 0, 0
	local tmp = nil
	for i=1,Len,1 do
		r1 = Random(1, Len)
		r2 = Random(1, Len)
		--不管r1 是否等于r2, 坚决不用if, 直接交换, 相等也不碍事
		self:Swap(r1,r2)
	end
end

--查找key(不是pop, 只查找, 不删除)
--成功返回'key指向的节点', 失败返回nil
function TabMMap:FindNode( key )
	local Len = self.Len
	local Key = self.Key
	local Val = self.Val
	local i = 0
	for i=1,Len,1 do
		if Key[i] == key then
			--成功不是break跳出循环, 而是直接return返回, 言外之意是:
			--		当for循环耗尽, 还没批评到元素的时候, 一定是找不到元素, 返回nil
			return {Key[i],Val[i]}
		end
	end
	return nil
end

--查找val
--成功返回'val指向的节点', 失败返回nil
function TabMMap:FindNodeByVal( val )
	local Len = self.Len
	local Key = self.Key
	local Val = self.Val
	local i = 0
	for i=1,Len,1 do
		if Val[i] == val then
			return {Key[i],Val[i]}
		end
	end
	return nil
end

--查找Pos指向的node
--成功返回'pos指向的节点', 失败返回nil
function TabMMap:FindNodeByPos( pos )
	local Len = self.Len
	local Key = self.Key
	local Val = self.Val
	local i = 0
	if Len >= pos and pos >= 1 then
		return {Key[pos],Val[pos]}
	else
		return nil
	end
end

--根据Key, 返回Key所在的Pos
--成功返回'key 节点的pos', 失败返回nil
function TabMMap:GetKeyPos( key )
	local Len = self.Len
	local Key = self.Key
	local i = 0
	for i=1,Len,1 do
		if Key[i] == key then
			return i
		end
	end
	return nil
end

--根据Pos 位置值, 插入元素(触发table重新排序)
function TabMMap:InsertPos( pos, key, val )
	local Insert = _G.table.insert
	local Key = self.Key
	local Val = self.Val
	local Len = self.Len
	Insert(Key, pos, key)
	Insert(Val, pos, val)
	self.Len = Len + 1
end

--根据Key 位置值, 在key所在的位置的后面, 插入元素(触发table重新排序)
function TabMMap:InsertKey( index_key, key, val )
	local Insert = _G.table.insert
	local Key = self.Key
	local Val = self.Val
	local Len = self.Len
	for i=1,Len,1 do
		if Key[i] == index_key then
			i = i + 1
			Insert(Key, i, key)
			Insert(Val, i, val)
			self.Len = Len + 1
			return
		end
	end
end

--根据Key 值, 删除元素(触发table重新排序)
--成功返回true, 失败返回false(debug only)
function TabMMap:Remove( key )
	local Remove = _G.table.remove
	local Key = self.Key
	local Val = self.Val
	local Len = self.Len
	local pos = self:GetKeyPos(key)
	if pos ~= nil then
		Remove(Key, pos)
		Remove(Val, pos)
		self.Len = Len - 1
		--return true
	--else
		--return false
	end
end

--根据Pos 位置值, 删除元素(触发table重新排序) [这个函数少用!! 不安全]
--成功返回true, 失败返回false(debug only)
function TabMMap:RemovePos( pos )
	local Remove = _G.table.remove
	local Key = self.Key
	local Val = self.Val
	local Len = self.Len
	if Len >= pos and pos >= 1 then
		Remove(Key, pos)
		Remove(Val, pos)
		self.Len = Len - 1
		--return true
	--else
		--return false
	end
end

--自测函数(不对外公开)
local function Test(t_map_str)
	local i = 0
	local t = nil
	t_map_str:PushFront("key", 9)
	t_map_str:PushBack("fff", "ff")
	t_map_str:PushFront("666", "fuc")
	t_map_str:PushBack("qq", "xx")
	t_map_str:InsertPos(2, "222", 222)
	t_map_str:InsertKey("222", "3333", 33333)
	print("t_map_str.Len\t=",t_map_str.Len)
	for i=1,t_map_str.Len,1 do
		print(t_map_str.Key[i],t_map_str.Val[i])
	end
	t_map_str:Shuffle()
	print("Shuffle(): t_map_str.Len\t=",t_map_str.Len)
	for i=1,t_map_str.Len,1 do
		print(t_map_str.Key[i],t_map_str.Val[i])
	end
	t_map_str:Sort()
	print("Sort(): t_map_str.Len\t=",t_map_str.Len)
	for i=1,t_map_str.Len,1 do
		print(t_map_str.Key[i],t_map_str.Val[i])
	end
	print("---")
	t = t_map_str:FindNodeByPos(2)
	print(t[1], t[2])
	t = t_map_str:FindNode("666")
	print(t[1], t[2])
	t = t_map_str:Front()
	print(t[1], t[2])
	t = t_map_str:Back()
	print(t[1], t[2])
	print(t_map_str:Count())
	t_map_str:Remove(2)
	t_map_str:Remove(19)
	t_map_str:RemovePos(1)
	t = t_map_str:PopFront()
	print(t[1], t[2])
	t = t_map_str:PopBack()
	print(t[1], t[2])
	--测试插入重复元素(应该成功)
	t_map_str:PushFront("666", "fuc")
	print("t_map_str.Len\t=",t_map_str.Len)
	for i=1,t_map_str.Len,1 do
		print(t_map_str.Key[i],t_map_str.Val[i])
	end
	print(t_map_str:Count())
	print(t_map_str:Empty())
	t_map_str:Clear()
	print(t_map_str:Empty())
end

--启动自测
local t_map_str=TabMMap:New("string"); if t_map_str ~= nil then Test(t_map_str) end

return TabMMap

