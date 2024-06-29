--[[
	desc:浅拷贝
	auth:Carol Luo
]]

local pairs = pairs
local clear = require("table.clear")

---浅拷贝
---@param t table @要拷贝的表
---@param out table @外带表
---@return table @新表
local function copy(t,out)
	if out then
		clear(out) 
	end
	local new = out or {nil}
	for k,v in pairs(t) do
		new[k]=v
	end
	return new
end

return copy