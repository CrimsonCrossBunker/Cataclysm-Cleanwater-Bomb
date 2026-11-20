local ccb = require("ccb")

return ccb.ModDefinition {
    id = "backrooms",
    name = ccb.content.text("The Backrooms"),
    authors = { "TGW" },
    maintainers = { "onura46" },
    description = ccb.content.text("A strange place between dimensions traps you.  Can you survive among endless halls of yellowed carpet and harshly humming fluorescents?\n\nReplaces all normal worldgen: no wilderness, no rivers, no cities, no farms, no sky.  Just endless, winding indoor halls of mildewy carpeting, faded drywall, desolate breakrooms and abandoned boardrooms.\n\nPlay Now!  (Default Scenario) is not supported."),
    category = "total_conversion",
    conflicts = { "aftershock_exoplanet", "desertpack", "tropicata", "classic_zombies", "innawood", "Isolation_Protocol", "no_hope" },
    dependencies = { "ccb" },
    version = "0.1",
    ordered_data_files = true,
}
