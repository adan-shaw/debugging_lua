local ifInt = require("ifInt")
---@type ifUInt
return function(v)
	return ifInt(v) and 0 == v%1 and v >= 0
end

---@alias ifUInt fun(v:any):boolean 