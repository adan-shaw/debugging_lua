--[[
	desc:范围分段随机
	auth:Carol Luo
]]

local math = math
local shuffle = require("shuffle")

---范围分段随机
---@param mini  integer    @开始数字
---@param maxi	integer    @结束数字
---@param need  integer    @需要个数
---@param list  integer[]    @数组容器
---@return integer[]
local function localf(mini,maxi,need,list)

	---几份
	---@type integer
	local part = math.floor((maxi - mini) / need)

	---余数
	local left = (maxi - mini) % need
	
	---最小
	local start = mini

	---最大
	local close = start + part

	---随机
	for i=1,need do
		list[i] = math.random(start,close)
		start,close = close,close + part
		if left > 0 then
			close = close + 1
			left = left - 1
		end
	end
	return shuffle(list)
end

return localf