local ccb = require("ccb")

ccb.content.define_spell {
    id = "terra_armor",
    name = ccb.content.text("Terra Armor"),
    description = ccb.content.text("Cover yourself in dense, invisible energy of Earth.  Higher level increase your defense abilities."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "effect_terra_armor",
    extra_spells = { { spell = "eoc_enhancement_setup", self = true } },
    shape = "blast",
    base_casting_time = 550,
    base_energy_cost = 750,
    min_duration = 50000,
    max_duration = 1800000,
    duration_increment = 50000,
    difficulty = 7,
    max_level = 35,
    flags = { "ENHANCEMENT_SPELL", "SOMATIC" },
    spell_class = "GAIAS_CHOSEN",
    magic_type = "magiclysm_enhancement_magic",
}
