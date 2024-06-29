local type = type
---@type ifFunction
return function(v)
	return 'function' == type(v)
end


---@alias ifFunction fun(v:any):boolean 
