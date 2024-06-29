#!/bin/sh

cd ./lua-aes
make clean
cd ..

cd ./lua-aes-crypto-all-files
rm ./aes128.so
rm ./aes192.so
rm ./aes256.so
cd ..
