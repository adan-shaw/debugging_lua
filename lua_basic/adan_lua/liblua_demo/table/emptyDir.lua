local pairs = pairs
local ifTable = require("ifTable")

---克隆目录结构
local function localf(t)
	local new = {}
	for k,v in pairs(t) do
		if ifTable(v) then
			new[k] = localf(v)
		end
	end
	return new
end

return localf