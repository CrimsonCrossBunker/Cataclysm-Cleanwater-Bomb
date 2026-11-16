local ccb = require("ccb")

return ccb.ModDefinition {
    world_options = {
        SELECT_STARTING_CITY = true,
        OVERMAP_PREGENERATED_PATH = "MA/MA_overmap",
    },
}
