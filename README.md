# WiFi Captive Portal detection program

## Background

When you connect to a WiFi network e.g. hotels or in public places, there will generally be a Captive portal page asking you for authorization information. If you don't get authorized in the portal page, you will not be able to use the Internet.

When you use a WiFi router to connect to such networks, there are more things to deal with in order to let the portal page pop up correctly. You need to:

* Disable all VPN connections in the router.
* Disable DNS rebind protection. This is generally true but not for all portal.
* Disable DNS encryption. In GL.iNet routers there are CloudFlare DNS. 

But if you use the router to protect data privacies, when you do the above, your data will be leaked. 

This program is used to solve this problem by manipulating the firewall without disabling your VPN and DNS protection manually while not leaking your data. 

## How it works

The program tries to detect if there is any WiFi portal page. If there is, it will allow the portal page to pass firewall and DNS encryption so that it will pop up in your client device connected to the router. After you authorize via the portal the firewall policy will be restored.

## Testing firmware URL

[GL.iNet AR750S](http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/ar750s/testing/gl-ar750s-portal-detect.tar) http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/ar750s/testing/gl-ar750s-portal-detect.tar

[GL.iNet MIFI](http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/mifi/testing/gl-mifi-portal-detect.bin)   http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/mifi/testing/gl-mifi-portal-detect.bin


## How to use 

You need to have a file `/etc/config/glconfig` to use this program

```
uci set glconfig.repeater.portal=1
uci commit glconfig
```
If you are GL.iNet testing firmware, you can do this directly in the repeater interface of the UI.

## Pre-requisite 

This program requires the following three pakages.

```
libcares libcurl dnsmasq-full
```

### How to compile 

First, we need curl to use libcares for asynchronous DNS resolution.[patch](https://github.com/gl-inet/openwrt/commit/2e032d245a642a3bdaa88d830edb063204be979f)
```
diff --git a/package/network/utils/curl/Makefile b/package/network/utils/curl/Makefile
index db72640..ba857b8 100644
--- a/package/network/utils/curl/Makefile
+++ b/package/network/utils/curl/Makefile
@@ -89,6 +89,7 @@ define Package/libcurl
   DEPENDS:= +LIBCURL_WOLFSSL:libwolfssl +LIBCURL_OPENSSL:libopenssl +LIBCURL_GNUTLS:libgnutls +LIBCURL_MBEDTLS:libmbedtls
   DEPENDS += +LIBCURL_ZLIB:zlib +LIBCURL_THREADED_RESOLVER:libpthread +LIBCURL_LDAP:libopenldap +LIBCURL_LIBIDN2:libidn2
   DEPENDS += +LIBCURL_SSH2:libssh2 +LIBCURL_NGHTTP2:libnghttp2
+  DEPENDS += libcares
   TITLE:=A client-side URL transfer library
   MENU:=1
 endef
@@ -104,7 +105,7 @@ TARGET_LDFLAGS += -Wl,--gc-sections
 
 CONFIGURE_ARGS += \
        --disable-debug \
-       --disable-ares \
+       --enable-ares \
        --enable-shared \
        --enable-static \
        --disable-manual \
```

Then,select  packages
```
-*- libcares.. Library for asyncronous DNS Requests (including name resolves)
-*- curl.................................. A client-side URL transfer utility
<*> dnsmasq-full
<*> gl-portal-detect................. Repeater automatically detect portal AP
```

Then compile the package

```
make  ./package/portal-detect/compile
```
## Install

```
opkg install gl-portal-detect
```

## Note

If that doesn't work, you might want to recompile curl and install it because it needs to support libares
