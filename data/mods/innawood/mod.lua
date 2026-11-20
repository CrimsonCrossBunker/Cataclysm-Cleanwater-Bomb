local ccb = require("ccb")

return ccb.ModDefinition {
    id = "innawood",
    name = ccb.content.text("Innawood"),
    authors = { "Lightwave" },
    maintainers = { "Lightwave" },
    description = ccb.content.text("An untouched land that mankind has yet to reach.  Disables most traces of civilization for that 'innawood' experience."),
    category = "total_conversion",
    conflicts = { "aftershock_exoplanet", "backrooms", "desertpack", "tropicata", "classic_zombies", "Isolation_Protocol", "no_hope" },
    dependencies = { "ccb" },
    loading_images = { "innawoods1.png" },
    disable_other_loading_screens = true,
    obsolete = false,
    ordered_data_files = true,
}
