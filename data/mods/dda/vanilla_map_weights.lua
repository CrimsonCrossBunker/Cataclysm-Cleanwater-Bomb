local ccb = require("ccb")
local services = ccb.services
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

-- WAVE16B_START
local function set_wave16b_map_weights()
    local days = (services.time.now().turn - services.time.calendar().start_of_cataclysm.turn) / 86400
    local clamped_days = math.max(0, days)
    local t = math.min(clamped_days, 365) / 365
    set_global("ws_survivor_camp_weight", math.max(25, math.min(350, (days * 2) + 25)))
    set_global("survivor_forest_camp_weight", math.max(100, math.min(250, days + 100)))
    set_global("s_grocery_unlooted_weight", 250 * (days < 365 and (1 - t * t) or 0))
    set_global("s_grocery_looted_weight", 250 + 250 * (days < 365 and (t * t) or 1))
end

local function schedule_wave16b_map_weights()
    set_wave16b_map_weights()
    ccb.tasks.after(86400, "w16b_daily_map_weights", {})
end

ccb.runtime.handler("w16b_set_map_weights", set_wave16b_map_weights)
ccb.runtime.handler("w16b_daily_map_weights", schedule_wave16b_map_weights)
ccb.runtime.handler("w16b_map_weights_ready", function()
    set_wave16b_map_weights()
    if not ccb.state.world.get("w16b_map_weights_started") then
        ccb.state.world.set("w16b_map_weights_started", true)
        ccb.tasks.after(86400, "w16b_daily_map_weights", {})
    end
end)
ccb.runtime.on("game:game_begin", "w16b_set_map_weights")
ccb.runtime.on("world_ready", "w16b_map_weights_ready")
-- WAVE16B_END
