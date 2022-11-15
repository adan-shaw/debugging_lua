--[[
	目标:
		利用linklist + key + value, 实现可以'频繁删除&插入'的mult map(只有在频繁增删的情况下有优势)

		不能批量插入/删除

		不允许相同的key键值
]]



local MMap = require "MMap"

local Map = {}

Map.__index = Map



--创建链表(自己保证元素的一致性, 否则没办法排序)
function Map:New( keyType )
	local t = {}
	local setmetatable = _G.setmetatable
	t.MMap = MMap:New(keyType)
	if t.MMap == nil then
		return nil
	else
		setmetatable(t, self)
		return t
	end
end

--返回第一个元素
--成功返回节点的key+val, 失败返回nil
function Map:Front()
	return self.MMap:Front()
end

--返回最后一个元素
--成功返回节点的key+val, 失败返回nil
function Map:Back()
	return self.MMap:Back()
end

--从Map头部插入元素
function Map:PushFront( key, val )
	--TabSet 不允许重复元素
	local tmp = self.MMap:Find(key)
	if tmp == nil then
		self.MMap:PushFront(key, val)
	end
end

--从Map尾部插入元素
function Map:PushBack( key, val )
	--TabSet 不允许重复元素
	local tmp = self.MMap:Find(key)
	if tmp == nil then
		self.MMap:PushBack(key, val)
	end
end

--从Map头部弹出元素
--成功返回节点的val元素值, 失败返回nil
function Map:PopFront()
	return self.MMap:PopFront()
end

--从Map尾部弹出元素
--成功返回节点的val元素值, 失败返回nil
function Map:PopBack()
	return self.MMap:PopBack()
end

--根据key, 查询元素是否存在, 存在则返回'第一个找到的元素'的node节点
--成功返回目标节点node, 失败返回nil
function Map:Find( key )
	return self.MMap:Find(key)
end

--根据Key, 返回Key所在的tmp table的Pos位置(绝对有问题)
--成功返回'key 节点的pos', 失败返回nil
function Map:GetKeyPosInTable( Tab, Len, key )
	return self.MMap:GetKeyPosInTable(Tab, Len, key)
end

--队列空?
--成功返回true, 失败返回false
function Map:Empty()
	return self.MMap:Empty()
end

--返回Map长度
function Map:Count()
	return self.MMap:Count()
end

--清空
function Map:Clear()
	self.MMap:Clear()
end

--根据key 值, 查找与该key 值匹配的'第一个找到的元素', 然后删除
function Map:Remove( key )
	self.MMap:Remove(key)
end

--根据key 值, 查找与该key 值匹配的'第一个找到的元素', 然后在其后一位插入元素
--找不到, 则自动在队尾添加元素
function Map:InsertKey( index_key, key, val )
	--TabSet 不允许重复元素
	local tmp = self.MMap:Find(key)
	if tmp == nil then
		self.MMap:InsertKey(index_key, key, val)
	end
end

--仅排序
function Map:Sort()
	self.MMap:Sort()
end

--仅乱序
function Map:Shuffle()
	self.MMap:Shuffle()
end

--仅返回一个带有所有元素的无序table
function Map:toTable_Only()
	return self.MMap:toTable_Only()
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
	print("t_map_str.MMap.Len\t=",t_map_str.MMap.Len)
	fristNode = t_map_str.MMap.First
	for i=1,t_map_str.MMap.Len,1 do
		print(fristNode.key, fristNode.val)
		fristNode = fristNode.rear
	end
	t_map_str:Shuffle()
	print("t_map_str.MMap.Len\t=",t_map_str.MMap.Len)
	fristNode = t_map_str.MMap.First
	for i=1,t_map_str.MMap.Len,1 do
		print(fristNode.key, fristNode.val)
		fristNode = fristNode.rear
	end
	t_map_str:Sort()
	print("t_map_str.MMap.Len\t=",t_map_str.MMap.Len)
	fristNode = t_map_str.MMap.First
	for i=1,t_map_str.MMap.Len,1 do
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
local t_map_str=Map:New("string"); if t_map_str ~= nil then Test(t_map_str) end

return Map
