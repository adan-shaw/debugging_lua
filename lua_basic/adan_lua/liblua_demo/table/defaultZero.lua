local pairs = pairs
local setmetatable = setmetatable
local ifTable = require("ifTable")

local meta = {
	__index = function(t,k)
		return 0
	end
}

---设置默认值0表
---@param tab table @表
---@return table
local function localf(tab)
	for _,v in pairs(tab) do
		if ifTable(v) then
			localf(v)
		end
	end
	return setmetatable(tab,meta)
end

return localf