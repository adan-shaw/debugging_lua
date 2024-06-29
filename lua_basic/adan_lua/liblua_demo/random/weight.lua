--[[
	desc: 权重随机
	auth: Carol Luo
]]--

local math = math
local table = table
local pairs = pairs
local ipairs = ipairs

---权重随机
---@param arr   number[] 权重配置
---@param sum   number				权重之和
---@return index
local function localf(arr,sum)
	local is = {}
	for i,_ in pairs(arr) do
		table.insert(is,i)
	end
	table.sort(is)
	local r = math.random(1,sum)
	for _,i in ipairs(is) do
		r = r - arr[i]
		if r <= 0 then
			return i
		end
	end
end

return localf