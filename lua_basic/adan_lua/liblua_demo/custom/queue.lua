--[[
	desc:队列	解决 table.remove(arr,1) 的问题
	auth:Carol Luo
]]

local math = math

local class = require("class")

---@class queue
local this = class()

---构造函数
function this:ctor()
	
	---数据列表
	---@type any[]
	self._list = {nil}

	---下标起点
	self._begin = 1
	---有效元素
	self._size = 0
end

---元素个数
---@return integer
function this:getSize()
	return self._size
end

---尾部添加
function this:push_back(value)
	if nil ~= value then
		local index = self._size + self._begin
		self._list[index] = value
		self._size = self._size + 1
	end
end 

---头部添加
function this:push_fron(value)
	if value then
		local index = self._begin
		if 1 ~= self._begin then
			index = index - 1
		end

		self._list[index] = value
		self._size = self._size + 1
	end
end 

---尾部删除
---@return T|nil
function this:pop_back()

	local index = self._size + self._begin - 1
	local value = self._list[index]

	if value then
		self._list[index] = nil
		self._size = self._size - 1
		return value
	end
end

---头部删除
---@return T|nil
function this:pop_fron()
	local value = self._list[self._begin]
	if value then
		self._list[self._begin] = nil
		self._begin = self._begin + 1
		self._size = self._size - 1
		return value
	end
end

---数据访问
---@generic t:any
---@param index index @下标
---@return T|nil
function this:get_data(index)
	index = index + self._begin - 1
	return self._list[index]
end

return this