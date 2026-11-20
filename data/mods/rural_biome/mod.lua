local ccb = require("ccb")

return ccb.ModDefinition {
    id = "ruralbiome",
    name = ccb.content.text("Rural-Only Mapgen"),
    authors = { "I-am-Erk" },
    description = ccb.content.text("Play in the boonies: nothing but farms, forests, and villages.  Recommended city size set to 1 and spacing set to 8."),
    category = "content",
    dependencies = { "ccb" },
    version = "0.1",
    obsolete = true,
    ordered_data_files = true,
    -- should not be deleted until actual biomes exist in the game
    world_options = {
        OVERMAP_PLACE_HIGHWAYS = false,
    },
}
