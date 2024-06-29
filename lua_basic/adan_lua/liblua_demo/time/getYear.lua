--[[
	desc:多少年
	auth:carol luo
]]

local os = os
local tonumber = tonumber

---多少年
---@param sec integer|nil @时间
---@return integer @毫秒
local function localf(sec)
	return tonumber(os.date("%Y",sec))
end

return localf