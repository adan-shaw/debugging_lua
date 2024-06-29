--[[
	desc:排行榜
	auth:Carol Luo
]]

local table = table
local class = require("class")
local traverse = require("search.traverse")
local sortInsert = require("sort.insert")
---@class ranking
local this = class()

---@class rank
---@field iden  any     @唯一标示
---@field score score   @排行积分

---构造函数
---@param max   count   @最大数量
function this:ctor(max)
	---最大数量
	---@type count
	self._max = max;
	---排行数据
	---@type rank[]
	self._lis = {};
	---映射数据
	---@type table<any,rank>
	self._map = {}
	---最低积分
	---@type score
	self._min = 0
end

---初始数据
function this:initial()
end


---启动函数
function this:launch()
end


---设置最低限制
---@param score score   @最低积分
function this:setMinScore(score)
	self._min = score
end


---比较函数
---@param a rank
---@param b rank
local function comp(a,b)
	return a.score > b.score
end

---更新数据
---@param iden  any     @唯一标识
---@param score score   @积分
function this:update(iden,score)

	--上榜限制
	if score < self._min then
		return
	end

	local lis = self._lis
	local map = self._map
	local inf = map[iden]
	--插入数据
	if not inf then
		inf = {
			iden = iden,
			score = score,
		}
		map[iden] = inf
		sortInsert(lis,comp,inf)
	--更新数据
	else
		inf.score = score
		local index = traverse(lis,inf)
		table.remove(lis,index);
		sortInsert(lis,comp,inf)
	end
end


---删除数据
---@param iden  any     @唯一标识
function this:remove(iden)
	local lis = self._lis
	local map = self._map
	local inf = map[iden]
	if not inf then
		return
	end
	map[iden] = nil
	local index = traverse(lis,inf)
	table.remove(lis,index);
end

return this