local modf = _G.math.modf



--判断一个number 是否是整形
local function if_num_int(num)
	local n,f=modf(num)
	if(f == 0) then
		return true
	else
		return false
	end
end



--判断一个number 是否是浮点
local function if_num_float(num)
	local n,f=modf(num)
	if(f ~= 0) then
		return true
	else
		return false
	end
end



--自我测试
--[[
	print(if_num_int(111))
	print(if_num_int(1.11))
	print(if_num_float(111))
	print(if_num_float(1.11))
]]



return {
	if_num_int = if_num_int,
	if_num_float = if_num_float
}
