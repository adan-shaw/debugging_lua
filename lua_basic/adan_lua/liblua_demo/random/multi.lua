--[[
	desc:不重复随机
	auto:Carol Luo
]]

local math = math
local table = table

---不重复随机
---@param lib any[]	 @随机库
---@param lis any[]	 @结果库
---@param cnt count  @要多少
---@return any[]
local function localf(lib,lis,cnt)

	local lenght  = #lib
	while lenght > 0 and cnt > 0 do

		---随机数据
		local index = math.random(1,lenght)

		---交换数据
		lib[lenght],lib[index] = lib[index],lib[lenght]

		---计算数量
		lenght = lenght - 1
		cnt = cnt - 1

		---保存结果
		local value = table.remove(lib)
		table.insert(lis,value)
	end
	
	return lis
end

return localf