local ccb = require("ccb")

return ccb.ModDefinition {
    id = "MA",
    name = ccb.content.text("Massachusetts"),
    authors = { "ZhilkinSerg" },
    maintainers = { "ZhilkinSerg" },
    description = ccb.content.text("Cataclysm in one state."),
    category = "total_conversion",
    dependencies = { "ccb" },
    conflicts = { "aftershock_exoplanet" },
    ordered_data_files = true,
    world_options = {
        SELECT_STARTING_CITY = true,
        OVERMAP_PREGENERATED_PATH = "MA/MA_overmap",
    },
}
