local type = type
---@type ifUserData
return function(v)
	return 'userdata' == type(v)
end

---@alias ifUserData fun(v:any):boolean 
