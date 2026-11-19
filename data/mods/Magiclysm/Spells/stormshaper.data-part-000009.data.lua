local ccb = require("ccb")

ccb.content.define_spell {
    id = "stormshaper_cloak_of_frog",
    name = ccb.content.text("Cloak of Frog"),
    description = ccb.content.text("Someone's personal notes were added to this spell.  You're positive that they changed both the name and the function."),
    valid_targets = { "self" },
    flags = { "TRANSFORMATION_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC", "NO_EXPLOSION_SFX" },
    effect = "attack",
    extra_spells = {
        { spell = "stormshaper_cloak_frog_transform", self = true },
        { spell = "stormshaper_cloak_frog_summon_wonder", self = false },
        { spell = "eoc_enhancement_setup", self = true },
    },
    shape = "blast",
    spell_class = "STORMSHAPER",
    difficulty = 4,
    max_level = 20,
    min_duration = 15000,
    max_duration = 90000,
    duration_increment = 3750,
    magic_type = "magiclysm_transformation_magic",
    base_energy_cost = 350,
    base_casting_time = 150,
}
