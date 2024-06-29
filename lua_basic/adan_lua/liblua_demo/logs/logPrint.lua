--[[
	auth:Carol Luo
]]

local os = os
local debug = debug
local table = table
local pairs = pairs
local print = print
local ipairs = ipairs
local tostring = tostring
local ifTable = require("ifTable")
local ifBoolean = require("ifBoolean")
local t2string = require("t2string")


local logSwitch = {
	logPrint = true,		---代表日志总开关
	logError = true,		---错误日志的开关
	logDebug = true,		---调试日志的开关
}

---日志打印
---@param mod string @模块名字
---@vararg any[]
---@return string
return function (mod,...)

	---打印开关
	if not logSwitch.logPrint then
		print("\n return log 1",mod,...)
		return false
	end

	---模块开关
	if not logSwitch[mod] then
		print("\n return log 2",mod,...)
		return false
	end

	---日志拼接
	local tb_lis = {}
	table.insert(tb_lis,mod)
	table.insert(tb_lis,"[")
	table.insert(tb_lis,os.date("%Y-%m-%d %H:%M:%S"))
	table.insert(tb_lis,"]")
	local args = {...}
	local res = ""
	for n, v in ipairs(args) do
		if ifTable(v) then
			table.insert(tb_lis,"\n")
			table.insert(tb_lis,t2string(v))
		elseif ifBoolean(v) then
			table.insert(tb_lis,"\n")
			table.insert(tb_lis,tostring(v))
		else
			table.insert(tb_lis,"\n")
			table.insert(tb_lis,tostring(v))
		end
	end
	
	table.insert(tb_lis,"\n")
	return print(table.concat(tb_lis)) 
end