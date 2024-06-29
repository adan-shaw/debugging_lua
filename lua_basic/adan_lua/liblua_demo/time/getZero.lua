--[[
	desc:0点时间搓
	auth:Carol Luo
]]

local getZone = require("time.getZone")

local upZone = {
	UTC = 3600*0,
	ECT = 3600*1,
	EET = 3600*2,
	ART = 3600*2,
	EAT = 3600*3,
	MET = 3600*3.5,
	NET = 3600*4,
	PLT = 3600*5,
	IST = 3600*5.5,
	BST = 3600*6,
	VST = 3600*7,
	CTT = 3600*8,
	JST = 3600*9,
	ACT = 3600*9.5,
	AET = 3600*10,
	SST = 3600*11,
	NST = 3600*12,
	MIT = 3600*-11,
	HST = 3600*-10,
	AST = 3600*-9,
	PST = 3600*-8,
	PNT = 3600*-7,
	MST = 3600*-7,
	CST = 3600*-6,
	EST = 3600*-5,
	IET = 3600*-5,
	PRT = 3600*-4,
	CNT = 3600*-3.5,
	AGT = 3600*-3,
	BET = 3600*-3,
	CAT = 3600*-1,
}

upZone = upZone[getZone()]
---0点时间搓
---@param sec integer|nil @时间
---@return sec
local function localf(sec)
	return sec - ((sec + upZone) % 86400)
end

return localf