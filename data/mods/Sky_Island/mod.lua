local ccb = require("ccb")

return ccb.ModDefinition {
    world_options = {
        -- If true, initial status and amount of fuel for all spawned vehicles will be overridden by
        -- values of VEHICLE_STATUS_AT_SPAWN and VEHICLE_FUEL_AT_SPAWN options.
        OVERRIDE_VEHICLE_INIT_STATE = true,
        -- All vehicles spawn in this status.  -1 is lightly damaged (default), 0 is undamaged, 1 is
        -- disabled (destroyed tires or engine).  Values are read only if OVERRIDE_VEHICLE_INIT_STATE
        -- is set to true.
        VEHICLE_STATUS_AT_SPAWN = 0,
    },
    interaction_world_options = {
        ["backrooms"] = {
            -- Reapply to override backrooms setting
            DEFAULT_REGION = "default_skyisland",
        },
    },
}
