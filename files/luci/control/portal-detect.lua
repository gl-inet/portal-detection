module("luci.controller.admin.portal-detect", package.seeall)
 
function index()
    entry({"admin", "network", "portal-detect"}, cbi("admin_network/portal-detect"), _("PortalDetect"), 1)
end
