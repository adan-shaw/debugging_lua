--[[
	desc:插入函数
	auth:Carol Luo
]]

local table = table
local remove = require("table.remove")

---插入函数
---@overload fun(t:table, value:any,count:number):number
---@param t table
---@param value any
---@param count number|nil
---@param maxim number|nil
---@return number
local function localf(t, value, count,maxim)

	if not count then
		return table.insert(t, value)
	end

	for i = 1,count do
		table.insert(t, value)
	end

	if maxim and #t > maxim then
		remove(t,maxim,#t)
	end

	return #t
end

return localf