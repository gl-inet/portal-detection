# Portal AP detect program

When GL travel router uses VPN,DNS Cloudflare and DNS Rebinding Attack Protection, It may not be able to access the portal authentication page.This program is used to handle such cases,and it automatically detects portal AP, allowing authentication pages to pass firewall and DNS authentication without authentication,after the authentication is complete, the normal policy is restored
## Testing firmware URL

[AR750S](http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/ar750s/testing/) http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/ar750s/testing/
[MIFI](http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/ar750s/testing/)   http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/mifi/testing/

## Enable

```
uci set glconfig.repeater.portal=1
uci commit glconfig
```
If you are testing firmware,  you can do this directly in the repeater interface of the UI.

## Source code URL

[github](https://github.com/luochongjun/portal-detect) https://github.com/luochongjun/portal-detect

### Depends

```
libcares libcurl dnsmasq-full
```

## Configuration

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

## Compile

```
make  ./package/portal-detect/compile
```
## Install

```
opkg install gl-portal-detect
```
## Notic

** If that doesn't work, you might want to recompile curl and install it because it needs to support libares **
