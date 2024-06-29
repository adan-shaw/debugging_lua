--[[
	desc:转数组结构
	auth:Carol Luo
]]

local table = table
local pairs = pairs
local clear = require("table.clear")

---处理成连续表
---@param t table @表
---@return any[]
local function localf(t,out)
	local new = clear(out or {})
	for k,v in pairs(t) do
		table.insert(new,v)
	end
	return new
end

return localf