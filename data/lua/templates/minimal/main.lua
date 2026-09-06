local ccb = require("ccb")
assert(ccb.platform_version == 1,
    "This Mod requires CCB Lua Platform v1; got " .. tostring(ccb.platform_version))

ccb.runtime.handler("welcome", function()
    ccb.services.message("Lua-first Mod is running.")
end)

ccb.runtime.on("world_ready", "welcome")
