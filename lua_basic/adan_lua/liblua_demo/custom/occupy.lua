--[[
	desc:占位标记
	auth:Carol Luo
]]

local next = next
local table = table
local class = require("class")

---@class occupy
local this = class()

---构造
---@param min number @最少数
---@param max number @最大数
function this:ctor(min,max)
	self._min = min	 --最少数
	self._max = max	 --最大数
	self._lim = min - 1 --刻度数
	self._cur = min - 1 --当前取
	self._cnt = 0	   --占数量
	self._lis = {nil}
end

---初始数据
function this:initial()
end

---启动函数
function this:launch()
	self._cur = self._min
end



---申请
---@return boolean
function this:fetch()

	--复用
	local lis = self._lis
	if next(lis) then
		self._cur = table.remove(lis)
		self._cnt = self._cnt + 1
		return true
	end

	--自增
	if self._lim < self._max then
		self._cur = self._lim + 1
		self._cnt = self._cnt + 1
		self._lim = self._lim + 1
		return true
	end
	return false
end

---回收
---@param mark number
function this:repay(mark)
	self._cnt = self._cnt - 1
	table.insert(self._lis,mark)
end

---读取
---@return number
function this:read()
	assert(self._cnt > 0,"After the first go get it")
	return self._cur
end

---数量
---@return count
function this:count()
	return self._cnt
end

return  this