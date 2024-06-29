--[[
	desc:间隔年
	auth:Carol Luo
]]

local os = os
local math = math

---日期表转秒间隔
---@param aSec   sec	@日期表
---@param bSec   sec	@日期表
---@return integer
local function localf(aSec,bSec)
	return math.abs(os.date("%Y",aSec) - os.date("%Y",bSec))
end

return localf