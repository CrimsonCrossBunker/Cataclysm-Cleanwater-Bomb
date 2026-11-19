local ccb = require("ccb")

return ccb.ModDefinition {
    ordered_data_files = true,
    world_options = {
        DISABLE_ROBOT_RESPONSE = true,
        -- The scenario selected by default in the character creator menu.
        GENERIC_SCENARIO_ID = "ddotd_cabin",
        -- Set to Edmonton, Alberta.
        LATITUDE = 53.55,
        LONGITUDE = -113.49,
        ZOMBIFY_INTO_ENABLED = false,
    },
}
