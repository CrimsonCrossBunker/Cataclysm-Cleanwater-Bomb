local ccb = require("ccb")

ccb.runtime.handler("welcome", function()
    ccb.services.message("Lua-first Mod is running.")
end)

ccb.runtime.on("world_ready", "welcome")
