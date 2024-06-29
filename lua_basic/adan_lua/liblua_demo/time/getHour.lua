--[[
	desc:几点钟
	auth:carol luo
]]

local os = os
local tonumber = tonumber

---几点钟
---@param sec integer|nil @时间
---@return integer @毫秒
local function localf(sec)
	return tonumber(os.date("%H",sec))
end

return localf