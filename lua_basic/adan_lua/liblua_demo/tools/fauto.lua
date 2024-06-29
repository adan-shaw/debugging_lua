--[[
	file:fauto.lua 
	desc:自增长函数
	auth:Carol Luo
]]

---自增长函数
---@param init integer|nil @初始值
---@return function
return function(init)
	local auto = init or 0
	---获取自增长正整数
	---@return number
	return function()
		auto=auto+1
		return auto
	end
end