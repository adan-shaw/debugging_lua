#!/bin/sh

lua_exe="/usr/bin/luajit"
#lua_exe="/usr/bin/luac"
#lua_exe="/usr/local/bin/luajit"
#lua_exe="/usr/local/bin/luac"

# 设置输入目录(包含Lua源代码文件的目录)
input_dir="./lua_src"

# 设置输出目录(用于存放编译后的.luac文件)
#output_dir="luac.out"
output_dir="luajit.out"

if [ ! -d $input_dir ];then
	exit -1
fi

# 如果输出目录不存在, 则创建它
if [ ! -d "$output_dir" ]; then
	mkdir -p "$output_dir"
fi

# 遍历输入目录中的所有.lua文件, 并进行编译
find "$input_dir" -type f -name "*.lua" | while read -r lua_file; do
	# 提取文件名(不包括路径)
	filename=$(basename "$lua_file")
	# 提取不包含扩展名的文件名
	basename_noext="${filename%.*}"
	# 构建输出文件的完整路径
	output_file="$output_dir/$basename_noext.out"
	# 使用luac编译文件
	#$lua_exe -o "$output_file" "$lua_file"
	$lua_exe -O3 -b "$lua_file" "$output_file" 
	# 输出编译信息
	echo "Compiled: $lua_file to $output_file"
done

echo "*********************************"
echo "All Files Compilation Completed!!"
echo "*********************************"

ok_sig="./luajit_OK"
echo `date` > $ok_sig
