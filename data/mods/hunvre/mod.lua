local ccb = require("ccb")

return ccb.ModDefinition {
    ordered_data_files = true,
    world_options = {
        -- The scenario selected by default in the character creator menu.
        GENERIC_SCENARIO_ID = "awakened",
        -- The profession selected by default in the character creator menu.
        GENERIC_PROFESSION_ID = "homeless",
        -- Sets the latitude used for sunrise/sunset times.  Defaults to Boston.
        LATITUDE = 0.0,
        -- Sets the longitude used for sunrise/sunset times.  Defaults to Boston.
        LONGITUDE = 62.0,
    },
}
