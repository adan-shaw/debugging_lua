#
# Copyright (C) 2013-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lua-aes
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/lua-aes
    SUBMENU:=Lua
    SECTION:=lang
    CATEGORY:=Languages
    TITLE:=lua-aes
    DEPENDS:= +lua 
    MAINTAINER:=jack.chen <jk110333@126.com>
endef

define Package/lua-aes/description
	Lua bindings to aes128 aes192 aes256
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./lua-aes/* $(PKG_BUILD_DIR)/
endef


define Package/lua-aes/install
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/aes*.so $(1)/usr/lib/lua
endef

$(eval $(call BuildPackage,lua-aes))
