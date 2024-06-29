local ifNumber = require("ifNumber")
---@type ifNumber
return function(v)
	return ifNumber(v) and 0 == v%1
end

---@alias ifNumber fun(v:any):boolean 