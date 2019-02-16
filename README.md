#Portal AP detect program
When GL travel router uses VPN,DNS Cloudflare and DNS Rebinding Attack Protection, It may not be able to access the portal authentication page.This program is used to handle such cases,and it automatically detects portal AP, allowing authentication pages to pass firewall and DNS authentication without authentication,after the authentication is complete, the normal policy is restored
##Testing firmware URL
[AR750S](http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/ar750s/testing/) http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/ar750s/testing/
[MIFI](http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/ar750s/testing/)   http://download.gl-inet.com.s3-website.us-east-2.amazonaws.com/firmware/mifi/testing/

##Usage
```
uci set glconfig.repeater.portal=1
uci commit glconfig
```
If you are testing firmware,  you can do this directly in the repeater interface of the UI.

##Source code URL
[github](https://github.com/luochongjun/portal-detect) https://github.com/luochongjun/portal-detect
###Depends
```
libcares libcurl dnsmasq-full
```
