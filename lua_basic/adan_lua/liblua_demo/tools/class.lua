--[[
	desc:单继承class
	auth:Carol Luo
]]

local peak = require("peak")

local _class = {}
local setmetatable = setmetatable

 ---调用基类对象
 local function fsuper(self,this, f, ...)
	return this.__base[f](self, ...)
end

---class 定义
---@generic T
---@param base T
---@return T
local  function localf(base)

	---@class class_type @class类型
	local class_type = {}
 
	---对象类型
	class_type.__base   = base
	class_type.__type   = 'class'
	class_type.ctor     = false
	
	---虚函数表
	local vtbl = {}

	_class[class_type] = vtbl

	if base then
		setmetatable(vtbl,{__index= _class[base]})
	end
	
	
	class_type.new = function(...)
		local object= {super = fsuper}
		object.__base  = class_type
		object.__type  = 'object'
		
		peak(object,"ctor",...)

		return  setmetatable(object,{ __index = _class[class_type]})
	end
 
	---设置构造方法
	return setmetatable(class_type,{
		__newindex = vtbl, 
		__index = vtbl,
	})
end

return localf