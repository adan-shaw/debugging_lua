--[[
	desc:间隔秒
	auth:Carol Luo
]]

---间隔秒
---@param date 	luaDate	@日期表
---@return sec
local function localf(date)
	return ((date.day or 0) * 86400) + ((date.hour or 0) * 3600) + ((date.min or 0) * 60) + (date.sec or 0)
end

return localf