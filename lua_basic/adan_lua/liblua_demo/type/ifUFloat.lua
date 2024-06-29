---@type ifUFloat
return function(v)
	return 0 ~= v % 1 and v >= 0
end

---@alias ifUFloat fun(v:any):boolean 