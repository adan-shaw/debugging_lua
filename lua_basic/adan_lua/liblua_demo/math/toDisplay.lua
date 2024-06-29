--[[
	desc:数字转展示
	auth:Carol Luo
]]


local tostring = tostring
local format = string.format

---数字转展示
---@param value number @实数
local function localf(value)
	if value < 10000 then
		return tostring(value)
	elseif value < 100000000 then
		return format("%.f万",value / 10000)
	end

	return format("%.f亿",value / 100000000)
end


return localf