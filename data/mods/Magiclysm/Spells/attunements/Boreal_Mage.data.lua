local ccb = require("ccb")

ccb.content.define_spell {
    id = "borealmage_auroral_guard",
    name = ccb.content.text("Auroral Guard"),
    description = ccb.content.text("Create a sturdy shell that wraps around your body, bestowing a sturdy defense."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "aura_auroral_guard",
    shape = "blast",
    magic_type = "magiclysm_conjuration_magic",
    flags = { "CONJURATION_SPELL", "CONCENTRATE", "VERBAL", "NO_LEGS" },
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    difficulty = 9,
    max_level = 40,
    base_casting_time = 350,
    base_energy_cost = 750,
    min_duration = 100000,
    max_duration = 2000000,
    duration_increment = 47500,
    spell_class = "BOREAL_MAGE",
}
