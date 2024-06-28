default : linux
.PHONY: linux clean test

CC =gcc 

PKGC ?= pkg-config

LUAPKG ?= lua lua5.1 lua5.2 lua5.3
# lua's package config can be under various names
LUAPKGC := $(shell for pc in $(LUAPKG); do \
		$(PKGC) --exists $$pc && echo $$pc && break; \
	done)

LUA_VERSION := $(shell $(PKGC) --variable=V $(LUAPKGC))
LUA_LIBDIR := $(shell $(PKGC) --variable=libdir $(LUAPKGC))
LUA_CFLAGS := $(shell $(PKGC) --cflags $(LUAPKGC))
LUA_LDFLAGS := $(shell $(PKGC) --libs-only-L $(LUAPKGC))

CFLAGS = -Wall -Os -pedantic -std=gnu99 $(LUA_CFLAGS) -L$(LUA_LIBDIR) $(LUA_LDFLAGS)
$(info CFLAGS=$(CFLAGS))
SHARED := -fPIC -shared

linux: aes128.so aes192.so aes256.so

aes128.so: aes.c laes.c
	$(CC) $(CFLAGS) $(SHARED) -DAES128=1 -o $@ $^

aes192.so: aes.c laes.c
	$(CC) $(CFLAGS) $(SHARED) -DAES192=1 -o $@ $^

aes256.so: aes.c laes.c
	$(CC) $(CFLAGS) $(SHARED) -DAES256=1 -o $@ $^

test:
	lua test.lua

clean:
	rm -f *.so
