#!/bin/sh

cd ./lua-aes
make -j4
make test
cd ..

cd ./lua-aes-crypto-all-files
ln -s ../lua-aes/aes128.so
ln -s ../lua-aes/aes192.so
ln -s ../lua-aes/aes256.so
cd ..
