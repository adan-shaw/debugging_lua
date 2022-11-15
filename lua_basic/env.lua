local getenv = _G.os.getenv
local setenv = _G.os.setenv



--[[
	os.getenv(varname)对于参数中的var_name是不区分大小写的;
	当var_name不存在时, 函数会返回nil

	setfenv(f, table): 设置一个函数的环境
		(1)当第一个参数为一个函数时, 表示设置该函数的环境
		(2)当第一个参数为一个数字时, 为1代表当前函数, 2代表调用自己的函数, 3代表调用自己的函数的函数, 以此类推.
	*性质: 函数的环境, 其实一个环境就是一个表, 该函数被限定为只能访问该表中的域, 或在函数体内自己定义的变量.
]]



--自我测试
--[[
	print(getenv("USERDOMAIN"))
	print(getenv("SystemRoot"))
	print(getenv("Os2LibPath"))
	print(getenv("ProgramFiles"))
	print(getenv("APPDATA"))
	print(getenv("ALLUSERSPROFILE"))
	print(getenv("CommonProgramFiles"))
	print(getenv("COMPUTERNAME"))
	print(getenv("USERNAME"))
	print(getenv("USERPROFILE"))
	print(getenv("ComSpec"))
	print(getenv("LOGONSERVER"))
	print(getenv("NUMBER_OF_PROCESSORS"))
	print(getenv("PATHEXT"))
	print(getenv("PROCESSOR_ARCHITECTURE"))
	print(getenv("PROCESSOR_IDENTIFIER"))
	print(getenv("PROCESSOR_LEVEL"))
	print(getenv("PROCESSOR_REVISION"))
	print(getenv("USERDOMAIN"))
	print(getenv("SystemRoot"))
	print(getenv("TEMP"))
	print(getenv("OS"))

	setenv("OS", "fuck you")
	print(getenv("OS"))

	--打印lua 版本
	print(_VERSION);
]]



return {
	getenv = getenv,
	setenv = setenv
}



