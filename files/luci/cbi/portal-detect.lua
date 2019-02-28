m = Map("portal-detect", "Portal detect")

s = m:section(NamedSection,"global","service")

s:option(Flag, "enable", "Enable","Enable service")
s:option(Value, "ifname","Device", "Device that need to be monitored.")
s:option(Value, "testpoint","Test point","Server IP for probing.").datatype = "ip4addr"
s:option(Value, "timeout","Timeout","Probe timeout,Effective range 1-60.").datatype = "range(1,60)"
s:option(Value, "interval","Interval","Probe interval,Effective range 5-60.").datatype = "range(5,60)"
s:option(Flag, "debug", "Debug","Enable debug mode")


return m -- Returns the map
