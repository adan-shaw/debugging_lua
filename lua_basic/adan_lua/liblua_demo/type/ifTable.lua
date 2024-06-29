local type = type
---@type ifTable
return function(v)
	return 'table' == type(v)
end

---@alias ifTable fun(v:any):boolean 
