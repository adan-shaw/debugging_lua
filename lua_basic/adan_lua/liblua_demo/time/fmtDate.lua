--[[
	desc:获取日期
	auth:carol luo
]]

local os = os

---获取日期
---@param sec integer|nil @时间
---@return string @毫秒
local function localf(sec)
	return os.date("%Y-%m-%d %H:%M:%S",sec)
end

return localf