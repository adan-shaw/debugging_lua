local math = math

---随机元素
---@param tab any[] @表
---@return val
local function localf(tab)
	local who = math.random(1,#tab)
	return tab[who]
end

return localf