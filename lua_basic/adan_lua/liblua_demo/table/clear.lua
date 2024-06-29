--[[
	desc:清除
	auth:Caorl Luo
]]

local pairs = pairs

---清空table {a={1}} to {nil}
---@param t table @表
---@return table|nil
local function clear(t)
	if not t then
		return
	end

	for k,v in pairs(t) do
		t[k] = nil
	end
	return t
end

return clear