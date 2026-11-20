local ccb = require("ccb")

return ccb.ModDefinition {
    ordered_data_files = true,
    world_options = {
        SELECT_STARTING_CITY = true,
        OVERMAP_PREGENERATED_PATH = "MA/MA_overmap",
    },
}
