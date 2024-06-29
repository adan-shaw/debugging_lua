--[[
	desc:获取日期
	auth:carol luo
]]

local os = os
local tonumber = tonumber

---获取日期
---@param sec integer|nil @时间
---@return luaDate @毫秒
local function localf(sec)
	return os.date("*t",sec)
end

return localf