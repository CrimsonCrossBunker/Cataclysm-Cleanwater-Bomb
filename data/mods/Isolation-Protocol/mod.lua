local ccb = require("ccb")

return ccb.ModDefinition {
    id = "Isolation_Protocol",
    name = ccb.content.text("Isolation Protocol"),
    authors = { "Candlebury" },
    maintainers = { "Candlebury" },
    description = ccb.content.text("A total conversion mod inspired by traditional dungeon crawler roguelikes.  Reach the bottom of an altered lab and prevent the Cataclysm from spreading to the surface!"),
    category = "total_conversion",
    dependencies = { "ccb" },
    conflicts = { "generic_guns", "aftershock_exoplanet", "innawood", "skyisland", "backrooms", "defense_mode", "MA", "tropicata", "desertpack", "classic_zombies", "no_hope" },
    ordered_data_files = true,
    world_options = {
        GENERIC_PROFESSION_ID = "iso_deliveryboy",
        GENERIC_SCENARIO_ID = "fractal_facility",
        WEARY_RECOVERY_MULT = 2.0,
        WOUND_CHANCE = 0.0,
        COMBAT_SPEED_MODIFIER = 1.66,
        DEFAULT_REGION = "default_isolation",
    },
}
