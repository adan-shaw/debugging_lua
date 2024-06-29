local ptab = require("print_tab").print_tab
local swap_num = require("def_basic").swap_num

local x = 999
local x2 = 111
print(x, x2)
--测试宏函数
x, x2 = swap_num(x, x2)
print(x, x2)
