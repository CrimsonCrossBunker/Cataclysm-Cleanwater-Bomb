local ccb = require("ccb")

return ccb.ModDefinition {
    id = "tropicata",
    name = ccb.content.text("TropiCataclysm"),
    authors = { "Xaritscin" },
    maintainers = { "Karol1223" },
    description = ccb.content.text("Changes the setting from New England to an undisclosed region in Brazil.  Initially based out of Desert Region mod."),
    category = "content",
    conflicts = { "aftershock_exoplanet", "backrooms", "desertpack", "classic_zombies", "innawood", "Isolation_Protocol", "no_hope" },
    dependencies = { "ccb" },
    version = "0.80",
    ordered_data_files = true,
    world_options = {
        -- Set to Marabá, eyeballing the rough climate match.
        LATITUDE = -5.42,
        LONGITUDE = -49.13,
    },
}
