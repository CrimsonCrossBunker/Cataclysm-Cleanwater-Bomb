local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "soothing_the_savage_beast_spell",
    name = ccb.content.text_without_extraction("Soothing the Savage Beast Perk Spell"),
    description = ccb.content.text_without_extraction("Soothes the savage beast if you have the perk.  You shouldn't have this."),
    message = "",
    teachable = false,
    valid_targets = { "hostile" },
    skill = "survival",
    flags = {
        "VERBAL",
        "RANDOM_DAMAGE",
        "RANDOM_DURATION",
        "NO_HANDS",
        "NO_LEGS",
        "NO_EXPLOSION_SFX",
        "SILENT",
    },
    effect = "charm_monster",
    shape = "blast",
    min_damage = 800,
    max_damage = 800,
    min_duration = 180000,
    max_duration = 540000,
    min_aoe = 6,
    max_aoe = 6,
    targeted_species = { "MAMMAL", "BIRD", "AMPHIBIAN", "REPTILE", "FISH" },
    ignored_species = {
        "ZOMBIE",
        "ROBOT",
        "ROBOT_FLYING",
        "NETHER",
        "NETHER_EMANATION",
        "LEECH_PLANT",
        "WORM",
        "FUNGUS",
        "SLIME",
        "PSI_NULL",
    },
}
