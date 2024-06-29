--[[
	desc:星期几
	auth:carol luo
]]

local os = os

local upday = {
	["0"] = 7,
	["1"] = 1,
	["2"] = 2,
	["3"] = 3,
	["4"] = 4,
	["5"] = 5,
	["6"] = 6,
}
---星期几
---@param sec integer|nil @时间
---@return integer @毫秒
local function localf(sec)
	local wday = os.date("%w",sec)
	return upday[wday]
end

return localf