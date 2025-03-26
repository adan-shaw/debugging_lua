--_G 全局变量:
--[[
	_G 全局变量, 是一个table, 有且只有一个(永恒单一);
	可以通过setfenv() 函数更换_G 全局变量table;

	Lua中的变量, 如果没有local关键字, 全都会添加进全局变量;

	_G全局函数的作用域是: 
		整个lua 虚拟机, 会一直存在, 直至lua 机退出;
		因此, 一般情况下, 禁止污染_G 全局变量table, 防止站着内存一直不释放, 除非是经常访问的函数/变量;
]]



--_G优化(不影响功能的前提下优化, 优化后, 这些功能都不能用了)
_G.assert = nil
_G.package.debug = nil
_G.error = nil
_G.debug = nil



--_G测试
--[[
	local ptab = require("print_tab").print_tab
	--打印默认的全局变量
	ptab(_G.debug)



	--全局变量清空
	_G = {}
	_G.add_val = "just a test message";
	ptab(_G)



	--全局变量释放(释放后, lua机仍然可以正常工作, 可以用来节省lua 机的内存)
	_G = nil
	_G = {}

	print("love you")
	next(_G)
]]



--_G 默认值
--[[
table: 0x403029d8{
    [coroutine]{
      [wrap]=function: builtin#37
      [yield]=function: builtin#34
      [resume]=function: builtin#35
      [status]=function: builtin#30
      [isyieldable]=function: builtin#32
      [running]=function: builtin#31
      [create]=function: builtin#33
    }
    [assert]=function: builtin#2
    [tostring]=function: builtin#18
    [tonumber]=function: builtin#17
    [io]{
      [input]=function: builtin#112
      [stdin]=file (0x7fe7398cba00)
      [tmpfile]=function: builtin#107
      [read]=function: builtin#109
      [output]=function: builtin#113
      [open]=function: builtin#105
      [close]=function: builtin#108
      [write]=function: builtin#110
      [popen]=function: builtin#106
      [flush]=function: builtin#111
      [type]=function: builtin#115
      [lines]=function: builtin#114
      [stdout]=file (0x7fe7398cc760)
      [stderr]=file (0x7fe7398cc680)
    }
    [rawget]=function: builtin#12
    [xpcall]=function: builtin#21
    [arg]{
      [0]=./_G.lua
      [-1]=/home/tarball/luajit/bin/luajit-2.1.0-beta3
    }
    [ipairs]=function: builtin#7
    [print]=function: builtin#29
    [pcall]=function: builtin#20
    [gcinfo]=function: builtin#26
    [module]=function: 0x40304f30
    [setfenv]=function: builtin#11
    [pairs]=function: builtin#5
    [jit]{
      [arch]=x64
      [version]=LuaJIT 2.1.0-beta3
      [version_num]=20100
      [status]=function: builtin#146
      [on]=function: builtin#143
      [os]=Linux
      [off]=function: builtin#144
      [flush]=function: builtin#145
      [attach]=function: builtin#147
      [opt]{
        [start]=function: builtin#159
      }
    }
    [bit]{
      [rol]=function: builtin#70
      [rshift]=function: builtin#68
      [ror]=function: builtin#71
      [bswap]=function: builtin#66
      [bxor]=function: builtin#74
      [bor]=function: builtin#73
      [arshift]=function: builtin#69
      [bnot]=function: builtin#65
      [tobit]=function: builtin#64
      [lshift]=function: builtin#67
      [tohex]=function: builtin#75
      [band]=function: builtin#72
    }
    [package]{
      [preload]{
        [table.clear]=function: 0x40305a88
        [ffi]=function: 0x40308d40
        [jit.util]=function: 0x40308c08
        [table.new]=function: 0x40305a38
        [jit.profile]=function: 0x40308bb8
      }
      [path]=./?.lua;/home/tarball/luajit/share/luajit-2.1.0-beta3/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/home/tarball/luajit/share/lua/5.1/?.lua;/home/tarball/luajit/share/lua/5.1/?/init.lua
      [loaded]{
        [coroutine]{

        }
        [print_tab]{
          [print_tab]=function: 0x40303418
        }
        [jit.opt]{

        }
        [math]{
          [ceil]=function: builtin#40
          [tan]=function: builtin#46
          [log10]=function: builtin#42
          [randomseed]=function: builtin#63
          [cos]=function: builtin#45
          [sinh]=function: builtin#50
          [random]=function: builtin#62
          [huge]=inf
          [pi]=3.1415926535898
          [max]=function: builtin#61
          [atan2]=function: builtin#56
          [ldexp]=function: builtin#59
          [floor]=function: builtin#39
          [sqrt]=function: builtin#41
          [deg]=function: 0x403078f8
          [atan]=function: builtin#49
          [fmod]=function: builtin#58
          [acos]=function: builtin#48
          [pow]=function: builtin#57
          [abs]=function: builtin#38
          [min]=function: builtin#60
          [sin]=function: builtin#44
          [frexp]=function: builtin#53
          [log]=function: builtin#55
          [tanh]=function: builtin#52
          [exp]=function: builtin#43
          [modf]=function: builtin#54
          [cosh]=function: builtin#51
          [asin]=function: builtin#47
          [rad]=function: 0x40307998
        }
        [package]{

        }
        [os]{
          [execute]=function: builtin#116
          [rename]=function: builtin#118
          [setlocale]=function: builtin#126
          [getenv]=function: builtin#120
          [difftime]=function: builtin#125
          [remove]=function: builtin#117
          [date]=function: builtin#123
          [exit]=function: builtin#121
          [time]=function: builtin#124
          [clock]=function: builtin#122
          [tmpname]=function: builtin#119
        }
        [_G]{

        }
        [bit]{

        }
        [string]{
          [find]=function: builtin#84
          [format]=function: builtin#89
          [rep]=function: builtin#79
          [gsub]=function: builtin#88
          [len]=function: 0x40306b80
          [gmatch]=function: builtin#87
          [dump]=function: builtin#83
          [match]=function: builtin#85
          [reverse]=function: builtin#80
          [byte]=function: builtin#76
          [char]=function: builtin#77
          [upper]=function: builtin#82
          [lower]=function: builtin#81
          [sub]=function: builtin#78
        }
        [debug]{
          [traceback]=function: builtin#142
          [setlocal]=function: builtin#134
          [getupvalue]=function: builtin#135
          [setupvalue]=function: builtin#136
          [upvalueid]=function: builtin#137
          [getlocal]=function: builtin#133
          [getregistry]=function: builtin#127
          [getinfo]=function: builtin#132
          [sethook]=function: builtin#139
          [setmetatable]=function: builtin#129
          [upvaluejoin]=function: builtin#138
          [gethook]=function: builtin#140
          [debug]=function: builtin#141
          [getmetatable]=function: builtin#128
          [setfenv]=function: builtin#131
          [getfenv]=function: builtin#130
        }
        [jit]{

        }
        [io]{

        }
        [table]{
          [maxn]=function: builtin#90
          [foreach]=function: 0x40305630
          [sort]=function: builtin#93
          [remove]=function: 0x40305870
          [foreachi]=function: 0x40305560
          [move]=function: 0x40305988
          [getn]=function: 0x403056c8
          [concat]=function: builtin#92
          [insert]=function: builtin#91
        }
      }
      [seeall]=function: 0x40304ca0
      [loadlib]=function: 0x40304c08
      [cpath]=./?.so;/usr/local/lib/lua/5.1/?.so;/home/tarball/luajit/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so
      [searchpath]=function: 0x40304c50
      [loaders]{
        [1]=function: 0x40304d38
        [2]=function: 0x40304d60
        [3]=function: 0x40304d88
        [4]=function: 0x40304db0
      }
      [config]=/
;
?
!
-

    }
    [error]=function: builtin#19
    [debug]{

    }
    [loadfile]=function: builtin#22
    [rawequal]=function: builtin#14
    [loadstring]=function: builtin#24
    [rawset]=function: builtin#13
    [unpack]=function: builtin#15
    [table]{

    }
    [require]=function: 0x40304f78
    [_VERSION]=Lua 5.1
    [newproxy]=function: builtin#28
    [collectgarbage]=function: builtin#27
    [dofile]=function: builtin#25
    [next]=function: builtin#4
    [math]{

    }
    [load]=function: builtin#23
    [os]{

    }
    [_G]{

    }
    [select]=function: builtin#16
    [string]{

    }
    [type]=function: builtin#3
    [getmetatable]=function: builtin#8
    [getfenv]=function: builtin#10
    [setmetatable]=function: builtin#9
}
]]
