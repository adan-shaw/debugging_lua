--[[
	desc:多少分钟
	auth:carol luo
]]

local os = os
local tonumber = tonumber

---多少分钟
---@param sec integer|nil @时间
---@return integer @毫秒
local function localf(sec)
	return tonumber(os.date("%M",sec))
end

return localf