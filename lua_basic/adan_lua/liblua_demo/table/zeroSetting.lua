local pairs = pairs
local ifTable = require("ifTable")
local ifNumber = require("ifNumber")
---置零数据
---@param t table @表
---@return table
local function localf(t)
	if not ifTable(t) then
		return
	end
	for k,v in pairs(t) do
		if ifNumber(v) then
			t[k] = 0
		elseif ifTable(v) then
			localf(v)
		end
	end
	return t
end

return localf