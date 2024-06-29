local ptab = require("print_tab").print_tab



--1.concat 将table 所有元素, 以某'间隔字符串'拼接, 组成一个新的string
local t1 = {1,2,3};
local str = table.concat(t1,",,,");
print(str);



--2.insert 插入元素(默认在最后一位插入)
table.insert(t1, -8);
--指定从下标4 插入元素[下标从1 开始]
table.insert(t1, 4, 999);
ptab(t1);



--3.remove 删除元素(必须指定元素下标; 找不到元素, 就不会做任何操作)[下标从1 开始]
table.remove(t1,1);
table.remove(t1,3);
ptab(t1);



--4.sort 重新排序
table.sort(t1);
ptab(t1);



--5.table 的遍历
--[[
	ipairs() or pairs() 遍历table, 性能差距都不大;
	遍历table 主要的性能差距是:
		table 是否是连续下标array table, 还是普通hash table(下标不连续)
		一般情况下, hash table 遍历性能比array table 慢

	--next() 遍历(另类的table 遍历方式)
]]

print("ipairs() 连续下标遍历")
for k,v in ipairs(t1) do
	print(k, v)
end

--nil 空值元素不表示
table.insert(t1, 1, nil);
table.insert(t1, 1, "fuck");
t1["f"] = "you"

print("pairs() 非连续下标遍历")
for k,v in pairs(t1) do
	print(k, v)
end

print("next() 非连续下标遍历")
local size = 0
local k, v = _G.next(t1)
while k do
    print(k, v)
    size = size + 1
    k, v = _G.next(t1, k)
end
print(size)



--6.检测table 是否为空
--非连续下标table 的非空检测
if(next(t1)) then
	print("t1 is not empty")
end

if(next(t1) == nil) then
	print("t1 is empty")
end

--连续下标table 的非空检测
t1 = {}
print(#t1)
if(#t1 == 0) then
	print("*** t1 is empty ***")
end





