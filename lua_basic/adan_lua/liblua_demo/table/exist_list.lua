local ipairs = ipairs
local ifExist = require("ifExist")

---是否存在某个值
---@param t     any    @表数据
---@param list  any[]  @值数据
---@return boolean
local function localf (t,list)
	for _,v in ipairs(list) do
		if not ifExist(t,v) then
			return false
		end
	end
	return true
end

return localf