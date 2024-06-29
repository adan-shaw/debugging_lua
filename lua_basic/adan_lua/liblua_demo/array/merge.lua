--[[
	desc:插入函数
	auth:Carol Luo
]]

local table = table
local ipairs = ipairs

---push函数
---@param t	 any[]
---@param s	 any[]
local function localf(t,s)
	for _,v in ipairs(s) do
		table.insert(t,v)
	end
	return t
end

return localf