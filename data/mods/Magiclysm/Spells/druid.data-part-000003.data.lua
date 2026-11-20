local ccb = require("ccb")

ccb.content.define_spell {
    id = "recover_sleepiness",
    name = ccb.content.text("Nature's Trance"),
    description = ccb.content.text("Your connection to living things allows you to go into a magical trance.  This allows you to recover from fatigue quickly in exchange for mana."),
    valid_targets = { "self" },
    flags = { "RESTORATION_SPELL", "RANDOM_DAMAGE", "CONCENTRATE", "SILENT", "NO_HANDS" },
    spell_class = "DRUID",
    magic_type = "magiclysm_restoration_magic",
    effect = "recover_energy",
    effect_data = "SLEEPINESS",
    shape = "blast",
    base_casting_time = 10000,
    min_damage = { handler = "scaled_recover_sleepiness_min_damage", fallback = 10.0 },
    max_damage = { handler = "scaled_recover_sleepiness_max_damage", fallback = 25.0 },
    max_level = 25,
    extra_spells = { { spell = "eoc_restoration_setup", self = true } },
    base_energy_cost = 500,
    energy_increment = 25,
    final_energy_cost = 1125,
    difficulty = 4,
}
