local ccb = require("ccb")
local variables = ccb.services.variables

ccb.runtime.handler("innawood_vanilla_map_weights", function()
    local result = variables.set_global("vanilla_trail_intersection_weight", 0, { include_before = false })
    if not result.ok then error(result.error.message) end
end)
ccb.runtime.on("game:game_begin", "innawood_vanilla_map_weights")
