--[[
	desc:间隔天
	auth:Carol Luo
]]

local os = os
local math = math
local getZero = require("time.getZero")

---间隔天
---@param aSec 	sec	@日期表
---@param bSec 	sec	@日期表
---@return integer
local function localf(aSec,bSec)
	aSec = getZero(aSec) + 28800
	bSec = getZero(bSec) + 28800
	return math.abs(aSec - bSec) // 86400
end

return localf