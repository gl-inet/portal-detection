#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gl-protal
PKG_VERSION:=3.0.1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/gl-protal
  SECTION:=base
  CATEGORY:=gl-inet
  TITLE+=gl-protal
endef

define Build/Compile
endef

define Package/gl-protal/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) ./files/protal $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(CP) ./files/40-protal-join $(1)/etc/hotplug.d/iface
	$(INSTALL_DIR) $(1)/etc/hotplug.d/net
	$(CP) ./files/40-protal-clear $(1)/etc/hotplug.d/net
endef

$(eval $(call BuildPackage,gl-protal))
