local select = select
---@type ifTypes
return function(fun,...)
	for i = 1,select('#',...) do
		if not fun(select(i,...)) then
			return false,i
		end
	end
	return true
end

---@alias ifTypes fun(v:any):boolean 