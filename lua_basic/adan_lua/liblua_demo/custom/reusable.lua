--[[
	desc:复用仓库
	auth:Caorl Luo
]]

local next = next
local table = table
local class = require("class")

---@class reusable
local this = class()

---构造
function this:ctor()
	self._list = {nil}
end

---初始数据
function this:initial()
end


---启动函数
function this:launch()
end

---申请(not clear)
---@return table
function this:get()
	local list = self._list
	if next(list) then
		return table.remove(list)
	else
		return {}
	end
end


---回收
---@param t table @表
function this:set(t)
	table.insert(self._list,t)
end

return this