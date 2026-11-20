local ccb = require("ccb")

return ccb.ModDefinition {
    id = "classic_zombies",
    name = ccb.content.text("Dark Days of the Dead"),
    authors = { "Hirmuolio", "I-am-Erk" },
    maintainers = { "I-am-Erk" },
    description = ccb.content.text("Turns the game into a classic Romero zombie game.  You must destroy the brain.  Getting bitten is fatal.  However, zombies don't evolve, and when they're down, they're down.  Removes the sci-fi and interdimensional aspects of CDDA.\n\nDark Days of the Dead is set in Alberta, Canada, sometime during the late 20th century.  Prepare for less advanced technology, rolling plains, and rainier weather."),
    conflicts = { "aftershock_exoplanet", "backrooms", "desertpack", "tropicata", "innawood", "Isolation_Protocol", "no_hope" },
    category = "total_conversion",
    dependencies = { "ccb" },
    loading_images = { "ddotd1.png" },
    disable_other_loading_screens = true,
    ordered_data_files = true,
    world_options = {
        DISABLE_ROBOT_RESPONSE = true,
        -- The scenario selected by default in the character creator menu.
        GENERIC_SCENARIO_ID = "ddotd_cabin",
        -- Set to Edmonton, Alberta.
        LATITUDE = 53.55,
        LONGITUDE = -113.49,
        ZOMBIFY_INTO_ENABLED = false,
    },
}
