a lua-bind for [aes](https://github.com/kokke/tiny-AES-c)
support aes128/aes192/aes256 mode 
support ecb/cbc/ctr  



#### 介绍
openwrt上自测可用的lua-aes128、192、256加解密工具, openwrt软件包的Makefile已实现;
run test,see test.lua for more details



#### Linux OS 安装教程
```
cd ./lua-aes-openwrt/lua-aes
make -j4 && make test
cp aes*.so /usr/local/lib/lua/5.1/
```



#### Openwrt OS 安装教程
```
cp -ra ./lua-aes-openwrt $openwrt_sdk/package/utils/lua-aes

make menuconfig
  choice lua-aes

make $openwrt_sdk/package/utils/lua-aes/compile V=s

```
