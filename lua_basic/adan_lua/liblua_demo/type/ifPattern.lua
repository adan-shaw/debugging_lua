--[[
	desc:匹配结构
	auth:Carol Luo
]]

local type = type
local pairs = pairs
local ifTable = require("ifTable")

---匹配结构
---@param a any @值1
---@param b any @值2
---@return boolean
local function ifPattern(a,b)
	---数据对比
	if a == b then
		return true
	end

	---类型检查
	if type(a) ~= type(b) then
		return false
	end

	---不是table
	if not ifTable(a) then
		return false
	end

	---不是table
	if not ifTable(b) then
		return false
	end

	for ak,av in pairs(a) do
		local bv = b[ak]
		--数据不同
		if av ~= bv then
			if not ifPattern(av,bv) then
				return false
			end
		end
	end
	return true
end

return ifPattern