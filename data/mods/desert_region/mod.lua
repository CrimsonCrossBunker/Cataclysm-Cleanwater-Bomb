local ccb = require("ccb")

return ccb.ModDefinition {
    ordered_data_files = true,
    world_options = {
        -- Set to Las Vegas.
        LATITUDE = 36.17,
        LONGITUDE = -115.14,
    },
}
