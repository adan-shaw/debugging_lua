--[[
	desc:string 标准库扩展
	auto:Carol Luo
]]

local table = table
local string = string
local clear = require("table.clear")

--[[
	字符串分割 支持正则
	param:	s	被拆分的string	
			p	分隔符(可以是正则表达式)
	return: {}拆分出来的序列表
]]

---字符串分割
---@param s string @字符
---@param p string @分割
---@param out table|nil @out
---@return string[]
local function localf(s, p ,out)
	local init = 1
	local ret = out or {}

	repeat
		---字符串查找
		local ibegin, iend, cap = string.find( s, p, init)

		---找到了字符串
		if nil ~= ibegin then

			---开头字符串
			if ibegin ~= init then
				table.insert( ret,  string.sub(s, init, ibegin-1))
			end

			---字符串内容
			if cap then
				table.insert( ret, cap)
			end

			---更新开始位置
			init = iend + 1

		---末尾字符串
		elseif string.len(s) >= init then
			table.insert( ret, string.sub(s,init) )
		end

	until nil == ibegin
	return ret
end


return localf

