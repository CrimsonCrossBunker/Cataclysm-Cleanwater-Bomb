local ccb = require("ccb")

return ccb.ModDefinition {
    world_options = {
        -- If false, it will disable the reduction in the maximum repairable damage capacity of vehicle parts when they are damaged.
        VEHICLE_DEGRADATION_WHEN_DAMAGE = false,
    },
}
