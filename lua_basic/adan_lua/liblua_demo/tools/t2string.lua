--[[
	desc:table 转字符串
	auto:Carol Luo
]]

local print = print
local pairs = pairs
local table = table
local string = string
local tostring = tostring
local ifTable = require("ifTable")
local clear = require("table.clear")
local ifNumber = require("ifNumber")
local ifBoolean = require("ifBoolean")
local ifString = require("ifString")

local tmap = {}
---table转字符串
---@param list 	string[]  					@存储字符串
---@param val  	table	 					@lua-table
---@param level	number|nil	 				@递归深度
---@param key	number|boolean|string|nil	@归属key值
local function _t2sList(list,val,level,key)
	if ifString(val) then
		table.insert( list,val)
	elseif not ifTable(val) then
		table.insert(list,tostring(val))
	end

	level = level or 0
	local indent
	if level > 0 then
		indent = string.rep("\t",level)
	else
		indent = ""
	end

	if ifString(key) then
		table.insert( list,"\r\n")
		table.insert( list,indent)
		table.insert( list,key)
		table.insert( list," = ")
		table.insert( list,"{")
	elseif ifNumber(key) then
		table.insert( list,"\r\n")
		table.insert( list,indent)
		table.insert( list,"[")
		table.insert( list,tostring(key))
		table.insert( list,"]")
		table.insert( list," = ")
		table.insert( list,"{")
	elseif ifTable(key) then
		_t2sList(list,key,level)
		table.insert( list,"\r\n")
		table.insert( list,"\r\n")
		table.insert( list,indent)
		table.insert( list," = ")
		table.insert( list,"\r\n")
	elseif ifBoolean(key) then
		table.insert( list,"[")
		table.insert(list,tostring(key))
		table.insert( list,"]")
	else
		table.insert( list,"{")
	end
	
	if ifTable(val) then
		table.insert( list,indent)
	else
		return
	end
	
	for k,v in pairs(val) do
		--v是table k非table
		if ifTable(v) then
			if  not tmap[v]  then
				tmap[v] = true
				_t2sList(list,v, level + 1,k)
			end
		else
			table.insert( list,"\r\n")
			table.insert( list,indent)
			table.insert( list,"\t")

			if ifString(k) then
				table.insert( list,k)
				table.insert( list," = ")
				if ifString(v) then
					table.insert( list,"\"")
					table.insert( list,v)
					table.insert( list,"\"")
				else
					table.insert( list,tostring(v))
				end
			else
				table.insert( list,"[")
				table.insert( list,tostring(k))
				table.insert( list,"]")
				table.insert( list," = ")
				if ifString(v) then
					table.insert( list,"\"")
					table.insert( list,v)
					table.insert( list,"\"")
				else
					table.insert( list,tostring(v))
				end
			end

			table.insert( list,",")
		end
	end
	
	table.insert( list,"\r\n")
	table.insert( list,indent)

	if level > 0 then
		table.insert( list,"},")
	else
		table.insert( list,"}")
	end
end


local copy1 = {}
---table转字符串
---@param  v table|string|function|thread|userdata|lightuserdata
---@return string
local  function localf(v)
	clear(tmap)
	if ifTable(v) then
		tmap[v] = true
		local list = clear(copy1)
		_t2sList(list,v,0)
		return table.concat(list)
	end
	return tostring(v)
end

return localf

