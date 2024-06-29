--[[
	desc:计算组合
	auth:Carol luo
]]

---计算组合
---@param sum integer @集合
---@param cnt integer @组合
local function localf(sum,cnt)
	if cnt < sum - cnt then
		cnt = sum - cnt;
	end

	local may = 1;
	for i = cnt + 1,sum do
		may = may * i
	end

	for i = 1,sum - cnt do
		may = may // i;
	end
	return may;
end


return localf