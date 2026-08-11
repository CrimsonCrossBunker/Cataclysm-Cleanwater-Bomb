local ccb = require("ccb")
local content = require("content.cleanwater_charm")
local behaviour = require("runtime.behaviour")

ccb.runtime.handler("use_cleanwater_charm", behaviour.use_charm, 1)
ccb.runtime.handler("lua_first_example_ready", behaviour.world_ready, 1)
ccb.runtime.handler("lua_first_example_reminder", behaviour.remind, 1)
ccb.runtime.on("world_ready", "lua_first_example_ready")

content.register(ccb)
