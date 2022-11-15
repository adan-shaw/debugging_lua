--[[
	基于List.lua, 目标是解决:
		频繁插入/删除时, queue 的性能问题(只有在频繁增删的情况下有优势)

		不能批量插入/删除

		允许相同的val元素值
--]]



local List = require "List"

local Queue = {}

Queue.__index = Queue



--创建链表(自己保证元素的一致性, 否则没办法排序)
function Queue:New( Type )
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
function Queue:Front()
	return self.List:Front()
end

--返回最后一个元素
--成功返回节点的val元素值, 失败返回nil
function Queue:Back()
	return self.List:Back()
end

--从Queue头部插入元素
function Queue:PushFront( val )
	self.List:PushFront(val)
end

--从Queue尾部插入元素
function Queue:PushBack( val )
	self.List:PushBack(val)
end

--从Queue头部弹出元素
--成功返回节点的val元素值, 失败返回nil
function Queue:PopFront()
	return self.List:PopFront()
end

--从Queue尾部弹出元素
--成功返回节点的val元素值, 失败返回nil
function Queue:PopBack()
	return self.List:PopBack()
end

--根据val元素值, 查询元素是否存在, 存在则返回'第一个找到的元素'的node节点
--成功返回目标节点node, 失败返回nil
function Queue:Find( val )
	return self.List:Find(val)
end

--队列空?
--成功返回true, 失败返回false
function Queue:Empty()
	return self.List:Empty()
end

--返回Queue长度
function Queue:Count()
	return self.List:Count()
end

--清空
function Queue:Clear()
	self.List:Clear()
end

--根据val 值, 查找与该val 值匹配的'第一个找到的元素', 然后删除
function Queue:Remove( val )
	self.List:Remove(val)
end

--根据val 值, 查找与该val 值匹配的'第一个找到的元素', 然后在其后一位插入元素
function Queue:Insert( index_val, val )
	self.List:Insert(index_val,val)
end

--仅排序
function Queue:Sort()
	self.List:Sort()
end

--仅乱序
function Queue:Shuffle()
	self.List:Shuffle()
end

--仅返回一个带有所有元素的无序table
function Queue:toTable_Only()
	return self.List:toTable_Only()
end

--自测函数(不对外公开)
local function Test(t_queue_num)
	local i = 0
	local fristNode = nil
	local t = nil
	t_queue_num:PushFront(19)
	t_queue_num:PushBack(1)
	t_queue_num:PushFront(1900)
	t_queue_num:PushBack(222)
	print("t_queue_num.List.Len\t=",t_queue_num.List.Len)
	fristNode = t_queue_num.List.First
	for i=1,t_queue_num.List.Len,1 do
		print(fristNode.val)
		fristNode = fristNode.rear
	end
	t_queue_num:Shuffle()
	print("t_queue_num.List.Len\t=",t_queue_num.List.Len)
	fristNode = t_queue_num.List.First
	for i=1,t_queue_num.List.Len,1 do
		print(fristNode.val)
		fristNode = fristNode.rear
	end
	t_queue_num:Sort()
	print("t_queue_num.List.Len\t=",t_queue_num.List.Len)
	fristNode = t_queue_num.List.First
	for i=1,t_queue_num.List.Len,1 do
		print(fristNode.val)
		fristNode = fristNode.rear
	end
	print(t_queue_num:Front())
	print(t_queue_num:Back())
	print(t_queue_num:Count())
	print(t_queue_num:PopFront())
	print(t_queue_num:PopBack())
	print(t_queue_num:Count())
	print(t_queue_num:Empty())
	print("toTable_Only():")
	t = t_queue_num:toTable_Only()
	for i=1,#t,1 do
		print(t[i])
	end
	t_queue_num:Clear()
	print(t_queue_num:Empty())
end

--启动自测
local t_queue_num=Queue:New("number"); if t_queue_num ~= nil then Test(t_queue_num) end

return Queue
