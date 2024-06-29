--[[
	desc:获取毫秒时间
	auth:Carol Luo
]]

local utime = require("usertime")

---毫秒
---@return integer @毫秒
local function localf()
	return utime.getmicrosecond()
end

return localf