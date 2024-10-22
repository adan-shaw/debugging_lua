#!/bin/sh


output_path="./luac.out"
if [ -d "$output_path" ];then
	rm -r $output_path
fi

output_path="./luajit.out"
if [ -d "$output_path" ];then
	rm -r $output_path
fi

ok_sig="./luac_OK"
if [ -f "$ok_sig" ];then
	rm $ok_sig
fi

ok_sig="./luajit_OK"
if [ -f "$ok_sig" ];then
	rm $ok_sig
fi
