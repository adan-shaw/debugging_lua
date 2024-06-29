--[[
	desc:存在判断
	auth:Carol Luo
]]

local pairs = pairs

---是否存在某个值
---@param t  table<any,any> @表数据
---@param v  any 			@值数据
---@return boolean|K
local function ifExits(t,v)
	for _k,_v in pairs(t) do
		if _v == v then
			return _k
		end
	end
	return false
end

return ifExits