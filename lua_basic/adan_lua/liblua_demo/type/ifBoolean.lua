local type = type
---@type ifBoolean
return function(v)
	return 'boolean' == type(v)
end

---@alias ifBoolean fun(v:any):boolean 
