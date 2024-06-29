--[[
	desc:多少月
	auth:carol luo
]]

local os = os
local tonumber = tonumber

---多少月
---@param sec integer|nil @时间
---@return integer @毫秒
local function localf(sec)
	return tonumber(os.date("%m",sec))
end

return localf