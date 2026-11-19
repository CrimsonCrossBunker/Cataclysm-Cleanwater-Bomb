local ccb = require("ccb")

return ccb.ModDefinition {
    ordered_data_files = true,
    world_options = {
        GENERIC_PROFESSION_ID = "iso_deliveryboy",
        GENERIC_SCENARIO_ID = "fractal_facility",
        WEARY_RECOVERY_MULT = 2.0,
        WOUND_CHANCE = 0.0,
        COMBAT_SPEED_MODIFIER = 1.66,
        DEFAULT_REGION = "default_isolation",
    },
}
