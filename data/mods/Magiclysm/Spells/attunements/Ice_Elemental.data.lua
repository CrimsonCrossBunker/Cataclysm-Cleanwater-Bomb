local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "cold_heart_slow",
    name = ccb.content.text_without_extraction("Cold Heart Slowdown"),
    description = ccb.content.text_without_extraction("Causes slowdown from the Cold Heart spell.  Subspell; you aren't allowed to see it except in debug mode."),
    valid_targets = { "hostile" },
    effect = "attack",
    shape = "blast",
    effect_data = "cold_heart_effect",
    max_level = 35,
    flags = { "SILENT" },
    min_duration = 6000,
    max_duration = 60000,
    duration_increment = 1550,
}

ccb.content.define_spell {
    id = "iceelemental_frostcrystal",
    name = ccb.content.text("Form Everfrost"),
    description = ccb.content.text("Drawing upon the cold in your own blood and the power of your magic you form a large piece of never-thawing ice."),
    valid_targets = { "ground" },
    effect = "ter_transform",
    effect_data = "icelemental_crystal",
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    shape = "blast",
    flags = { "CONJURATION_SPELL", "SOMATIC", "LOUD", "MUST_HAVE_CLASS_TO_LEARN" },
    spell_class = "ICE_ELEMENTAL",
    magic_type = "magiclysm_conjuration_magic",
    difficulty = 5,
    base_casting_time = 30000,
    final_casting_time = 300,
    casting_time_increment = -850,
    base_energy_cost = 1500,
    max_level = 35,
    min_range = 3,
    max_range = 10,
    range_increment = 0.2,
}
