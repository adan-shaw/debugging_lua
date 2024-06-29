@echo off
setlocal enabledelayedexpansion

REM 设置输入和输出目录
set "input_dir=C:\path\to\lua\source"
set "output_dir=C:\path\to\lua\compiled"

REM 如果输出目录不存在, 则创建它
if not exist "%output_dir%" mkdir "%output_dir%"

REM 遍历输入目录中的所有.lua文件, 并进行编译
for /r "%input_dir%" %%i in (*.lua) do (
    set "src_file=%%i"
    set "output_file=!output_dir!\!filename:~%cd%\!input_dir!!\"!filename:~-4!.luac"
    luac -o "!output_file!" "!src_file!"
    echo Compiled: !src_file! to !output_file!
)

echo Compilation completed.
pause
