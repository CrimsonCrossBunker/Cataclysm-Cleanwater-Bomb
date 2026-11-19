local ccb = require("ccb")

ccb.content.define_spell {
    id = "technomancer_welder",
    name = ccb.content.text("Voltaic Touch"),
    description = ccb.content.text("Using the principles of what were once called \"voltaic arcs\", you can electrically heat metal hot enough to weld it together."),
    valid_targets = { "self" },
    flags = { "CONJURATION_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC", "NO_EXPLOSION_SFX" },
    effect = "spawn_item",
    effect_data = "technomancer_welder",
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    shape = "blast",
    spell_class = "TECHNOMANCER",
    difficulty = 5,
    max_level = 15,
    min_damage = 1,
    max_damage = 1,
    min_duration = 360000,
    max_duration = 720000,
    duration_increment = 24000,
    magic_type = "magiclysm_conjuration_magic",
    base_energy_cost = 300,
    base_casting_time = 3000,
}
