--[[
	desc:深拷贝
	auth:Carol Luo
]]

local pairs = pairs
local clear = require("table.clear")
local ifTable = require("ifTable")

---浅拷贝
---@param t table @要拷贝的表
---@param out table @外带表
---@return table @新表
local function clone(t,out)
	if out then
		clear(out) 
	end
	local new = out or {nil}
	for k,v in pairs(t) do
		if ifTable(v) then
			new[k] = clone(v)
		else
			new[k] = v
		end
	end
	return new
end

return clone