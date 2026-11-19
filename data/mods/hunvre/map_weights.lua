local ccb = require("ccb")
local variables = ccb.services.variables

ccb.runtime.handler("hunvre_vanilla_map_weights", function()
    local result = variables.set_global("vanilla_road_weight", 0, { include_before = false })
    if not result.ok then error(result.error.message) end
end)
ccb.runtime.on("game:game_begin", "hunvre_vanilla_map_weights")
