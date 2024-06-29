--[[
	desc:(特殊拷贝)
	auth:Carol Luo
]]

local next = next
local table = table
local pairs = pairs
local setmetatable = setmetatable
local ifTable = require("ifTable")
local clone = require("table.clone")

---代理拷贝
---@generic T:any
---@param src table @默认值表
---@param shell fun(cmd:string):boolean @命令
---@return fun(tag:true|nil):T
local function localf(src,shell)

	local meta = {__index = src}
	if shell and shell("pairs") then
		---是否支持pairs
		local arr = {}
		local map = {}
		local ptr = {}
		local idx = 0
		for key, val in pairs(src) do
			idx = idx + 1
			arr[idx] = key
			map[key] = idx
			if ifTable(val) then
				ptr[key] = true
			end
		end

		function meta.__pairs(t)
			local iterator = function(t,k)
				if nil == k then
					k = arr[1]
				else
					k = arr[map[k] + 1]
				end
				return k,t[k]
			end
			return iterator,t,nil
		end
	end
	
	local new = nil
	---@type fun():T
	return function()
		if shell and shell("single") then
			if new then 
				return new
			end
		end

		new = {}
		if shell and shell("clone") then
			---table数据重新拷贝一份
			for k,_ in pairs(ptr) do
				new[k] = clone(src[k])
			end
		end
		return setmetatable(new,meta)
	end
end

return localf
