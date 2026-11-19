local ccb = require("ccb")

return ccb.ModDefinition {
    ordered_data_files = true,
    world_options = {
        -- Set to Marabá, eyeballing the rough climate match.
        LATITUDE = -5.42,
        LONGITUDE = -49.13,
    },
}
