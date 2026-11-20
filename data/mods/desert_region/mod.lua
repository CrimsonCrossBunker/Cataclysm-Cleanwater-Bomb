local ccb = require("ccb")

return ccb.ModDefinition {
    id = "desertpack",
    name = ccb.content.text("Desert Region"),
    authors = { "Dpwb", "DracoGriffin" },
    maintainers = { "LovamkKicsiGazsii", "Procyonae" },
    description = ccb.content.text("A testbed/WIP mod to showcase regional_map_settings JSON changes."),
    category = "content",
    conflicts = { "aftershock_exoplanet", "backrooms", "tropicata", "classic_zombies", "innawood", "Isolation_Protocol", "no_hope" },
    dependencies = { "ccb" },
    version = "0.1",
    obsolete = false,
    ordered_data_files = true,
    world_options = {
        -- Set to Las Vegas.
        LATITUDE = 36.17,
        LONGITUDE = -115.14,
    },
}
