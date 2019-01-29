#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gl-portal
PKG_VERSION:=3.0.6
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/gl-portal
  SECTION:=base
  CATEGORY:=gl-inet
  TITLE+=gl-portal
endef

define Build/Compile
endef

define Package/gl-portal/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) ./files/portal $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(CP) ./files/40-portal-join $(1)/etc/hotplug.d/iface
	$(INSTALL_DIR) $(1)/etc/hotplug.d/net
	$(CP) ./files/40-portal-clear $(1)/etc/hotplug.d/net
endef

$(eval $(call BuildPackage,gl-portal))
