--[[
	desc:是否同一分钟
	auth:Carol Luo
]]

local os = os

---是否同日
---@param aTime number @时间
---@param bTime number @时间
---@return boolean
local function localf(aTime,bTime)
	return os.date("%Y%m%d%H%M",aTime) == os.date("%Y%m%d%H%M",bTime)
end

return localf