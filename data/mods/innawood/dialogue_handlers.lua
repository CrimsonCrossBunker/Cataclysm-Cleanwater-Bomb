local ccb = require("ccb")
local services = ccb.services
local H = {}

ccb.runtime.handler("dlg_p_innawood_c0c4514d741e", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) < 90)
end)

ccb.runtime.handler("dlg_p_innawood_e56eebad836d", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 90)
end)
