local ccb = require("ccb")

ccb.content.define_spell {
    id = "druid_naturebow1",
    name = ccb.content.text("Nature's Bow"),
    description = ccb.content.text("This spell conjures a magical wooden recurve bow, as well as a quiver and a set of arrows to go with it."),
    valid_targets = { "none" },
    flags = { "CONJURATION_SPELL", "CONCENTRATE", "SOMATIC", "VERBAL", "NO_LEGS" },
    extra_spells = {
        { spell = "druid_naturequiver1" },
        { spell = "druid_naturearrows1" },
        { spell = "eoc_summon_setup", self = true },
    },
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "druid_recurve",
    shape = "blast",
    base_casting_time = 200,
    base_energy_cost = 250,
    min_duration = 24000,
    max_duration = 360000,
    duration_increment = 24000,
    difficulty = 5,
    max_level = 15,
    spell_class = "DRUID",
    magic_type = "magiclysm_conjuration_magic",
    learned_spells = { { spell = "druid_naturebow1_plus", level = 15 } },
}
