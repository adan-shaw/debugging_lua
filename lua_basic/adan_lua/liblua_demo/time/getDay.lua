--[[
	desc:多少号
	auth:carol luo
]]

local os = os
local tonumber = tonumber

---多少月
---@param sec integer|nil @时间
---@return integer @毫秒
local function localf(sec)
	return tonumber(os.date("%d",sec))
end

return localf