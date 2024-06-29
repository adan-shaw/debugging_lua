local table = table
local ipairs = ipairs


---过滤拷贝
---@param t      any[]        @要拷贝的表
---@param out    table        @外带表
---@param filter function|nil @过滤函数
local function localf(t,filter,out)
	if out then
		table.clear(out) 
	end

	local new =  out or {nil}
	for k,v in ipairs(t) do
		if not filter or filter(k,v) then
			table.insert(new,v)
		end
	end

	return new
end


return localf