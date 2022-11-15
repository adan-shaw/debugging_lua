--[[
	说明:
		在TabList 的基础上, 改造出TabMap, 
		元素少的情况下, 也可以适当频繁插入/删除(最好就不要频繁插入/删除)

		可以批量插入元素, 可以批量导出元素

		不允许相同的key键值
--]]



local TabMMap = require "TabMMap"

local TabMap = {}

TabMap.__index = TabMap

--创建map(keyType = number/string/anything)
--成功返回table, 失败返回nil
--[自己保证元素的一致性, 否则没办法排序]
function TabMap:New( keyType )
	local t = {}
	local setmetatable = _G.setmetatable
	t.TabMMap = TabMMap:New(keyType)
	if t.TabMMap == nil then
		return nil
	else
		setmetatable(t, self)
		return t
	end
end

--查看队头元素(不操作, 只查看)
--成功返回'Front节点', 失败返回nil
function TabMap:Front()
	return self.TabMMap:Front()
end

--查看队尾元素(不操作, 只查看)
--成功返回'Back节点', 失败返回nil
function TabMap:Back()
	return self.TabMMap:Back()
end

--从Back队尾插入
--成功返回true, 失败返回false(debug only)
function TabMap:PushBack( key, val )
	--TabSet 不允许重复元素
	local tmp = self.TabMMap:FindNode(key)
	if tmp == nil then
		self.TabMMap:PushBack(key, val)
	end
end

--从Back队尾弹出
--成功返回'Back节点', 失败返回nil
function TabMap:PopBack()
	return self.TabMMap:PopBack()
end

--从Front队头插入
--成功返回true, 失败返回false(debug only)
function TabMap:PushFront( key, val )
	--TabSet 不允许重复元素
	local tmp = self.TabMMap:FindNode(key)
	if tmp == nil then
		self.TabMMap:PushFront(key, val)
	end
end

--从Front队头弹出
--成功返回'Front节点', 失败返回nil
function TabMap:PopFront()
	return self.TabMMap:PopFront()
end

--栈空?
--成功返回true, 失败返回false
function TabMap:Empty()
	return self.TabMMap:Empty()
end

--返回栈当前元素的长度
function TabMap:Count()
	return self.TabMMap:Count()
end

--清空(重置)
function TabMap:Clear()
	self.TabMMap:Clear()
end

--交换元素
function TabMap:Swap(x,y)
	self.TabMMap:Swap(x,y)
end

--重新排序, 打乱TabMap 原来的顺序[先进先出TabMap禁用](直接使用_G.table.sort()进行排序)
function TabMap:Sort()
	self.TabMMap:Sort()
end

--洗牌乱序, 打乱TabMap 原来的顺序, 随机排序(anything 也可以乱序)
function TabMap:Shuffle()
	self.TabMMap:Shuffle()
end

--查找key(不是pop, 只查找, 不删除)
--成功返回'key指向的节点', 失败返回nil
function TabMap:FindNode( key )
	return self.TabMMap:FindNode(key)
end

--查找val
--成功返回'val指向的节点', 失败返回nil
function TabMap:FindNodeByVal( val )
	return self.TabMMap:FindNodeByVal(val)
end

--查找Pos指向的node
--成功返回'pos指向的节点', 失败返回nil
function TabMap:FindNodeByPos( pos )
	return self.TabMMap:FindNodeByPos(pos)
end

--根据Key, 返回Key所在的Pos
--成功返回'key 节点的pos', 失败返回nil
function TabMap:GetKeyPos( key )
	return self.TabMMap:GetKeyPos(key)
end

--根据Pos 位置值, 插入元素(触发table重新排序)
function TabMap:InsertPos( pos, key, val )
	--TabSet 不允许重复元素
	local tmp = self.TabMMap:FindNode(key)
	if tmp == nil then
		self.TabMMap:InsertPos(pos, key, val)
	end
end

--根据Key 位置值, 在key所在的位置的后面, 插入元素(触发table重新排序)
function TabMap:InsertKey( index_key, key, val )
	--TabSet 不允许重复元素
	local tmp = self.TabMMap:FindNode(key)
	if tmp == nil then
		self.TabMMap:InsertKey(pos, key, val)
	end
end

--根据Key 值, 删除元素(触发table重新排序)
--成功返回true, 失败返回false(debug only)
function TabMap:Remove( key )
	self.TabMMap:Remove(key)
end

--根据Pos 位置值, 删除元素(触发table重新排序) [这个函数少用!! 不安全]
--成功返回true, 失败返回false(debug only)
function TabMap:RemovePos( pos )
	self.TabMMap:Remove(pos)
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
	t_map_str:InsertKey("222", "666", 33333)
	print("t_map_str.TabMMap.Len\t=",t_map_str.TabMMap.Len)
	for i=1,t_map_str.TabMMap.Len,1 do
		print(t_map_str.TabMMap.Key[i],t_map_str.TabMMap.Val[i])
	end
	t_map_str:Shuffle()
	print("Shuffle(): t_map_str.TabMMap.Len\t=",t_map_str.TabMMap.Len)
	for i=1,t_map_str.TabMMap.Len,1 do
		print(t_map_str.TabMMap.Key[i],t_map_str.TabMMap.Val[i])
	end
	t_map_str:Sort()
	print("Sort(): t_map_str.TabMMap.Len\t=",t_map_str.TabMMap.Len)
	for i=1,t_map_str.TabMMap.Len,1 do
		print(t_map_str.TabMMap.Key[i],t_map_str.TabMMap.Val[i])
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
	--测试插入重复元素(应该不成功)
	t_map_str:PushFront("666", "fuc")
	print("t_map_str.TabMMap.Len\t=",t_map_str.TabMMap.Len)
	for i=1,t_map_str.TabMMap.Len,1 do
		print(t_map_str.TabMMap.Key[i],t_map_str.TabMMap.Val[i])
	end
	print(t_map_str:Count())
	print(t_map_str:Empty())
	t_map_str:Clear()
	print(t_map_str:Empty())
end

--启动自测
local t_map_str=TabMap:New("string"); if t_map_str ~= nil then Test(t_map_str) end

return TabMap
