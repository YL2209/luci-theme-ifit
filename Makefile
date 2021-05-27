# LuCI Theme Infinity Freedom
# Copyright 2020 Richard Yu <xiaoqingfengatgm@gmail.com>
#
# Licensed under the Apache License v2.0
# http://www.apache.org/licenses/LICENSE-2.0

include $(TOPDIR)/rules.mk

THEME_NAME:=ifit
THEME_TITLE:=ifit

PKG_NAME:=luci-theme-$(THEME_NAME)
PKG_VERSION:=20200706
PKG_RELEASE:=0

include $(INCLUDE_DIR)/package.mk

define Package/luci-theme-$(THEME_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=4. Themes
  DEPENDS:=+libc
  TITLE:=Infinity Freedom Theme
  URL:=https://github.com/kenzok8/luci-theme-ifit
  PKGARCH:=all
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-theme-$(THEME_NAME)/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/10_luci-theme-$(THEME_NAME) $(1)/etc/uci-defaults/luci-theme-$(THEME_NAME)	
	$(INSTALL_DIR) $(1)/www/luci-static/$(THEME_NAME)
	$(CP) -a ./files/htdocs/* $(1)/www/luci-static/$(THEME_NAME)/ 2>/dev/null || true
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/themes/$(THEME_NAME)
	$(CP) -a ./files/templates/* $(1)/usr/lib/lua/luci/view/themes/$(THEME_NAME)/ 2>/dev/null || true
endef

define Package/luci-theme-$(THEME_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-theme-$(THEME_NAME) ]; then
		( . /etc/uci-defaults/luci-theme-$(THEME_NAME) ) && \
		rm -f /etc/uci-defaults/luci-theme-$(THEME_NAME)
	fi
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
fi
exit 0
endef

$(eval $(call BuildPackage,luci-theme-$(THEME_NAME)))
