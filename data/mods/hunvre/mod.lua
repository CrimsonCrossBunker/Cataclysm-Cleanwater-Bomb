local ccb = require("ccb")

return ccb.ModDefinition {
    id = "hunvre",
    name = ccb.content.text("Hunvre"),
    authors = { "BalthazarArgall" },
    description = ccb.content.text("A sci-fi, claustrophobic spin on DDA."),
    category = "total_conversion",
    dependencies = { "ccb" },
    conflicts = { "aftershock_exoplanet", "backrooms", "bombastic_perks", "classic_zombies", "crazy_cataclysm", "deadly_bites", "defense_mode", "desertpack", "DinoMod", "extra_mut_scens", "innawood", "Isolation_Protocol", "MA", "magiclysm", "megacity_mod", "megafauna", "mindovermatter", "mom_knacks_only", "MMA", "my_sweet_cataclysm", "Mythos-Creatures", "no_hope", "package_bionic_professions", "perk_melee_system", "railroads", "Rummaging", "ruralbiome", "skyisland", "sorcerer", "Tamable_Wildlife", "translate_dialogue", "tropicata", "xedra_evolved", "xedra_evolved_innawoods" },
    data_path = "json/",
    loading_images = { "hunvre_loading_screen.png", "hunvre_loading_screen_1.png", "hunvre_loading_screen_2.png", "hunvre_loading_screen_3.png" },
    disable_other_loading_screens = true,
    ordered_data_files = true,
    world_options = {
        -- The scenario selected by default in the character creator menu.
        GENERIC_SCENARIO_ID = "awakened",
        -- The profession selected by default in the character creator menu.
        GENERIC_PROFESSION_ID = "homeless",
        -- Sets the latitude used for sunrise/sunset times.  Defaults to Boston.
        LATITUDE = 0.0,
        -- Sets the longitude used for sunrise/sunset times.  Defaults to Boston.
        LONGITUDE = 62.0,
    },
}
