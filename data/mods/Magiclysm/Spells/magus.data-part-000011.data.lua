local ccb = require("ccb")

ccb.content.define_spell {
    id = "magus_ranged_increase",
    name = ccb.content.text("Arrowflight"),
    description = ccb.content.text("A popular military spell since ancient times, Arrowflight increases the range of bows and, as it later turned out, firearms."),
    valid_targets = { "self", "ally" },
    spell_class = "MAGUS",
    flags = { "ENHANCEMENT_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    extra_spells = { { spell = "eoc_enhancement_setup", self = true } },
    effect = "attack",
    effect_data = "effect_magus_ranged_increase",
    shape = "blast",
    difficulty = 5,
    max_level = 15,
    min_range = 1,
    max_range = 1,
    min_duration = 36000,
    max_duration = 576000,
    duration_increment = 36000,
    magic_type = "magiclysm_enhancement_magic",
    base_energy_cost = 350,
    base_casting_time = 300,
}
