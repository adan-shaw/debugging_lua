local type = type
---@type ifNil
return function(v)
	return 'nil' == type(v)
end

---@alias ifNil fun(v:any):boolean 
