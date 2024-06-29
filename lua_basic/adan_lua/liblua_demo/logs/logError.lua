--[[
	auth:Carol Luo
]]

local debug = debug
local logPrint = require("logPrint")
return function(...)
	return logPrint("logError",...)
end