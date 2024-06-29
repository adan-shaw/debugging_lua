--[[
	desc:多少秒
	auth:carol luo
]]

local os = os
local tonumber = tonumber

---多少秒
---@param sec integer|nil @时间
---@return integer @毫秒
local function localf(sec)
	return tonumber(os.date("%S",sec))
end

return localf