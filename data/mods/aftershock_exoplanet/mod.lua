local ccb = require("ccb")

return ccb.ModDefinition {
    id = "aftershock_exoplanet",
    name = ccb.content.text("Aftershock: Exoplanet"),
    authors = { "Maleclypse", "Candlebury", "Mom_Bun" },
    maintainers = { "Maleclypse", "Candlebury", "Drew4484" },
    description = ccb.content.text("In a fateful instant, the dream of interstellar civilization was shattered in what became known as The Discontinuity, and billions were consigned to death in the far reaches of the Orion Arm.  Three hundred years later, the survivors still eke out a meager existence within the ruins of their once-great civilization, scavenging and fighting for scraps of technology they can barely understand.\n\nYou are one of these countless scavengers, come to exploit the frozen ruins of Salus IV for your own benefit."),
    category = "total_conversion",
    dependencies = { "ccb" },
    conflicts = { "mindovermatter", "generic_guns", "skyisland", "backrooms", "desertpack", "tropicata", "classic_zombies", "innawood", "Isolation_Protocol", "MA", "no_hope", "catalegacy_future", "immortal_path", "xedra_evolved" },
    loading_images = { "aftershock.png" },
    disable_other_loading_screens = true,
    ordered_data_files = true,
    world_options = {
        GENERIC_PROFESSION_ID = "afs_salvor",
        GENERIC_SCENARIO_ID = "augustmoon",
        ZOMBIFY_INTO_ENABLED = false,
        WOUND_CHANCE = 0.0,
        CBM_SLOTS_ENABLED = true,
        GAME_EMP = true,
        CAPITALISM = true,
    },
}
