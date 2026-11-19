local ccb = require("ccb")
local variables = ccb.services.variables

local function set_global(key, value)
    local result = variables.set_global(key, value, { include_before = false })
    if not result.ok then error(result.error.message) end
end

ccb.runtime.handler("aftershock_vanilla_map_weights", function()
    set_global("vanilla_bridge_weight", 0)
    set_global("vanilla_road_weight", 0)
end)
ccb.runtime.on("game:game_begin", "aftershock_vanilla_map_weights")
