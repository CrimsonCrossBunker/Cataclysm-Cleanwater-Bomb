local ccb = require("ccb")
local behaviour = require("runtime.behaviour")
local token_content = require("content.token")

ccb.runtime.handler("activate_cleanwater_token", behaviour.activate, 1)
ccb.runtime.handler("world_ready", behaviour.world_ready, 1)
ccb.runtime.handler("remind", behaviour.remind, 1)
ccb.runtime.on("world_ready", "world_ready")

token_content.register(ccb)
