#
# Copyright (C) 2019 GL.iNet
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gl-portal-detect
PKG_VERSION:=3.0.13
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/gl-portal-detect
  SECTION:=base
  CATEGORY:=gl-inet
  TITLE+=Repeater automatically detect portal AP
  DEPENDS:=+dnsmasq-full +libcurl +libcares
endef

define Build/Compile
endef

define Package/gl-portal-detect/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) ./files/portal-detect $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(CP) ./files/40-portal-join $(1)/etc/hotplug.d/iface
	$(INSTALL_DIR) $(1)/etc/hotplug.d/net
	$(CP) ./files/40-portal-clear $(1)/etc/hotplug.d/net
	$(INSTALL_DIR) $(1)/etc/init.d
	$(CP) ./files/init.d/* $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/config/* $(1)/etc/config
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/admin/
	$(CP) ./files/luci/control/* $(1)/usr/lib/lua/luci/controller/admin/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/admin_network/
	$(CP) ./files/luci/cbi/* $(1)/usr/lib/lua/luci/model/cbi/admin_network/
endef

$(eval $(call BuildPackage,gl-portal-detect))
