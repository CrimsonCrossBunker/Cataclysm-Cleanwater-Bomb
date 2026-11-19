local ccb = require("ccb")
local variables = ccb.services.variables

local function set_global(key, value)
    local result = variables.set_global(key, value, { include_before = false })
    if not result.ok then error(result.error.message) end
end

ccb.runtime.handler("dda_vanilla_map_weights", function()
    set_global("vanilla_bridge_weight", 1000)
    set_global("vanilla_road_weight", 1000)
    set_global("vanilla_lake_weight", 1000)
end)
ccb.runtime.on("game:game_begin", "dda_vanilla_map_weights")
