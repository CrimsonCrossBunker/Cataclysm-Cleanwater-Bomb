local ccb = require("ccb")

ccb.runtime.handler("portal_storm_cycle", function() end)
ccb.runtime.handler("portal_storm_cycle_interval", function()
    return ccb.services.random.native_int(10 * 24 * 3600, 11 * 24 * 3600)
end)
