--[[
	desc:属性计算器
	auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local class = require("class")
local reusable = require("reusable")
local clear = require("table.clear")
local absorb = require("table.absorb")
local ventgas = require("table.ventgas")
local conver = require("power.conver")


---@class power @力量计算
local this = class()
function this:ctor()
	---属性记录列表
	---@type table<uuid,allPowers>
	self._list = {}
	---属性查询列表-向下查询
	---@type table<uuid,table<uuid,true>>
	self._lower = {}
	---属性查询列表-向上查询
	---@type table<uuid,table<uuid,true>>
	self._upper = {}
	---属性缓存列表
	---@type table<uuid,allPowers>
	self._cache = {}
	---table仓库
	---@type reusable
	self._store = reusable.new()
end

---注册属性
---@param uuid     string           @唯一属性标识
---@param lower    table<uuid,true> @向下属性查询(包含自己)
---@param upper    table<uuid,true> @向上属性查询(包含自己)
function this:register(uuid,lower,upper)
	assert(uuid and lower and upper and lower ~= upper)
	assert(not self._list[uuid])
	assert(not self._lower[uuid])
	assert(not self._upper[uuid])
	self._list[uuid] = {}
	self._lower[uuid] = lower
	self._upper[uuid] = upper
end

---穿戴关系
---@param bodyUUID uuid @被穿戴对象
---@param caseUUID uuid @将穿戴对象
function this:wears(bodyUUID,caseUUID)
	assert(bodyUUID and bodyUUID and bodyUUID ~= caseUUID)
	---我上行的下行
	local bodyUpper = self._upper[bodyUUID]
	for kuuid, _ in pairs(bodyUpper) do
			local lower = self._lower[kuuid]
			lower[caseUUID] = true
	end
	---我下行的上行
	local caseLower = self._lower[caseUUID]
	for kuuid, _ in pairs(caseLower) do
		local upper = self._upper
		upper[bodyUUID] = true
	end

end

---卸载关系
---@param bodyUUID uuid @被卸载对象
---@param caseUUID uuid @将卸载对象
function this:unload(bodyUUID,caseUUID)
	assert(bodyUUID and bodyUUID and bodyUUID ~= caseUUID)
	---我上行的下行
	local bodyUpper = self._upper[bodyUUID]
	for kuuid, _ in pairs(bodyUpper) do
			local lower = self._lower[kuuid]
			lower[caseUUID] = nil
	end

	---我下行的上行
	local caseLower = self._lower[caseUUID]
	for kuuid, _ in pairs(caseLower) do
		local upper = self._upper
		upper[bodyUUID] = nil
	end
end

---增加属性
---@param uuid  string      @唯一属性标识
---@param attr  allPowers   @增加属性值
function this:append(uuid,attr)
	local cache = self._list[uuid]
	absorb(cache.abs,attr.abs)
	absorb(cache.per,attr.per)
	absorb(cache.buf,attr.buf)
	self:clear(uuid)
end

---扣除属性
---@param uuid  string      @唯一属性标识
---@param attr  allPowers   @增加属性值
function this:deduct(uuid,attr)
	local cache = self._list[uuid]
	ventgas(cache.abs,attr.abs)
	ventgas(cache.per,attr.per)
	ventgas(cache.buf,attr.buf)
	self:clear(uuid)
end

---申请数据
---@return allPowers
function this:feach()
	return self._store:get()
end

---回收数据
---@param attr allPowers
function this:recycle(attr)
	return self._store:set(attr)
end


local copy1 = {nil}
---计算战力
---@param attr allPowers    @属性
---@return allPowers
function this:power(attr)
	attr.zdl = 0

	---换算百分比属性
	local tarr = clear(copy1)
	for k, v in pairs(attr.abs) do
		tarr[k] = v + v * (attr.per[k] or 0)
	end

	---计算数值属性
	for k, v in pairs(tarr) do
		attr.zdl = attr.zdl + v * conver.att[k]
	end 

	---计算技能属性
	for k, v in pairs(attr.buf) do
		attr.zdl = attr.zdl + conver.buf[k]
	end 

	return attr
end

---计算属性
---@param uuid  string      @唯一属性标识
---@return allPowers
function this:calcul(uuid)
	local cache = self._cache[uuid] or self:feach()

	---计算属性
	if not cache.zdl then
		---总数据收集
		local map = self._lower[uuid]
		for kuuid,_ in pairs(map) do
				local attr = self._list[kuuid]
				absorb(cache.abs,attr.abs)
				absorb(cache.per,attr.per)
				absorb(cache.buf,attr.buf)
		end

		---总属性计算
		self:power(cache)
	end

	return cache
end

---清理缓存
---@param uuid uuid @缓存标识
function this:clear(uuid)
	local map = self._upper[uuid]
	for kuuid,_ in ipairs(map) do
		local cache = self._cache[kuuid]
		if cache then
			self:recycle(cache)
			self._cache[kuuid] = nil
		end
	end
end

return this