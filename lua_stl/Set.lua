--[[
	基于List.lua, 目标是解决:
		频繁插入/删除时, set 的性能问题(只有在频繁增删的情况下有优势)

		不能批量插入/删除

		不允许相同的val元素值
--]]



local List = require "List"

local Set = {}

Set.__index = Set



--创建链表(自己保证元素的一致性, 否则没办法排序)
function Set:New( Type )
	local setmetatable = _G.setmetatable
	local t = {}
	t.List = List:New(Type)
	if t.List == nil then
		return nil
	else
		setmetatable(t, self)
		return t
	end
end

--返回第一个元素
--成功返回节点元素值, 失败返回nil
function Set:Front()
	return self.List:Front()
end

--返回最后一个元素
--成功返回节点的val元素值, 失败返回nil
function Set:Back()
	return self.List:Back()
end

--从Set头部插入元素
function Set:PushFront( val )
	--TabSet 不允许重复元素
	local tmp = self.List:Find(val)
	if tmp == nil then
		self.List:PushFront(val)
	end
end

--从Set尾部插入元素
function Set:PushBack( val )
	--TabSet 不允许重复元素
	local tmp = self.List:Find(val)
	if tmp == nil then
		self.List:PushBack(val)
	end
end

--从Set头部弹出元素
--成功返回节点的val元素值, 失败返回nil
function Set:PopFront()
	return self.List:PopFront()
end

--从Set尾部弹出元素
--成功返回节点的val元素值, 失败返回nil
function Set:PopBack()
	return self.List:PopBack()
end

--根据val元素值, 查询元素是否存在, 存在则返回'第一个找到的元素'的node节点
--成功返回目标节点node, 失败返回nil
function Set:Find( val )
	return self.List:Find(val)
end

--队列空?
--成功返回true, 失败返回false
function Set:Empty()
	return self.List:Empty()
end

--返回Set长度
function Set:Count()
	return self.List:Count()
end

--清空
function Set:Clear()
	self.List:Clear()
end

--根据val 值, 查找与该val 值匹配的'第一个找到的元素', 然后删除
function Set:Remove( val )
	self.List:Remove(val)
end

--根据val 值, 查找与该val 值匹配的'第一个找到的元素', 然后在其后一位插入元素
function Set:Insert( index_val, val )
	--TabSet 不允许重复元素
	local tmp = self.List:Find(val)
	if tmp == nil then
		self.List:Insert(index_val,val)
	end
end

--对Set 进行排序(拆散, 将元素倒入新的table, sort后再倒出)
--直接交换两个节点的元素值即可, 不需要动链表结构!!
--成功返回一个'带有所有元素的有序table', 失败返回nil
--(该函数可以两用: 可以先排序, 然后返回一个'带有所有元素的有序table';
--也可以仅排序, 不要table;
--Set转换为table的性能消耗, 和排序是一样的, 可以两用, 尽量两用)
function Set:SortEx()
	return self.List:SortEx()
end

--对Set 进行'洗牌乱序'
--成功返回一个带有所有元素的无序table, 失败返回nil
function Set:ShuffleEx()
	return self.List:ShuffleEx()
end

--仅排序
function Set:Sort()
	self.List:Sort()
end

--仅乱序
function Set:Shuffle()
	self.List:Shuffle()
end

--仅返回一个带有所有元素的无序table
function Set:toTable_Only()
	return self.List:toTable_Only()
end

--自测函数(不对外公开)
local function Test(t_set_num)
	local i = 0
	local fristNode = nil
	local t = nil
	t_set_num:PushFront(19)
	t_set_num:PushBack(1)
	t_set_num:PushFront(1900)
	t_set_num:PushBack(222)
	print("t_set_num.List.Len\t=",t_set_num.List.Len)
	fristNode = t_set_num.List.First
	for i=1,t_set_num.List.Len,1 do
		print(fristNode.val)
		fristNode = fristNode.rear
	end
	t_set_num:Shuffle()
	print("t_set_num.List.Len\t=",t_set_num.List.Len)
	fristNode = t_set_num.List.First
	for i=1,t_set_num.List.Len,1 do
		print(fristNode.val)
		fristNode = fristNode.rear
	end
	t_set_num:Sort()
	print("t_set_num.List.Len\t=",t_set_num.List.Len)
	fristNode = t_set_num.List.First
	for i=1,t_set_num.List.Len,1 do
		print(fristNode.val)
		fristNode = fristNode.rear
	end
	print(t_set_num:Front())
	print(t_set_num:Back())
	print(t_set_num:Count())
	print(t_set_num:PopFront())
	print(t_set_num:PopBack())
	print(t_set_num:Count())
	print(t_set_num:Empty())
	print("toTable_Only():")
	t = t_set_num:toTable_Only()
	for i=1,#t,1 do
		print(t[i])
	end
	t_set_num:Clear()
	print(t_set_num:Empty())
end

--启动自测
local t_set_num=Set:New("number"); if t_set_num ~= nil then Test(t_set_num) end

return Set
