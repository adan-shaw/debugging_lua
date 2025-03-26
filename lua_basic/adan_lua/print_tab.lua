--lua api 前置解析
local write = _G.io.write
local type = _G.type
local tostring = _G.tostring
local pairs = _G.pairs



--打印table 函数
local function print_tab(t)
		local print_tab_cache={}

		--打印子函数
		local function sub_print_tab(t, backspace)
			if(print_tab_cache[tostring(t)]) then
				write("\n")
			else
				print_tab_cache[tostring(t)]=true
				if(type(t)=="table") then
					for k,v in pairs(t) do
						if(type(v)=="table") then
							write(backspace, "  [", k, "]{\n")
							sub_print_tab(v, backspace.."  ")
							write(backspace, "  }\n")
						else
							write(backspace, "  [", k, "]=", tostring(v), "\n")
						end
					end
				else
					write("\n")
				end
			end
		end

		--打印table
		if(type(t)=="table") then
			write(tostring(t), "{\n")
			sub_print_tab(t, "  ")
			write("}\n")
		else
			--非table 数据格式, 拒绝打印
			write("print_tab() err: parameter is not table\n")
		end
end



--自我测试
--print_tab(_G)
--print_tab("love you")
--print_tab(nil)



--require return(引用请求返回)
return {
	print_tab = print_tab
}


