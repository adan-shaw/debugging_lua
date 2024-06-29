local pairs = pairs
local ifTable = require("ifTable")

---清空数据 {a={1}} to {a={nil}}
---@param t table @表
---@return table
local function localf(t)
	if not ifTable(t) then
		return
	end
	for k,v in pairs(t) do
		if not ifTable(v) then
			t[k] = nil
		else
			localf(v)
		end
	end
	return t
end

return localf