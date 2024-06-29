local ifInt = require("ifInt")
---@type ifWeek
return function(v)
	return ifInt(v) and v >= 1 and v <= 7
end

---@alias ifWeek fun(v:any):boolean 