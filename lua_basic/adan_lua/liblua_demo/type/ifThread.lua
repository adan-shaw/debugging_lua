local type = type
---@type ifThread
return function(v)
	return 'thread' == type(v)
end

---@alias ifThread fun(v:any):boolean 
