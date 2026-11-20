local ccb = require("ccb")

ccb.content.define_spell {
    id = "create_rune_technomancer",
    name = ccb.content.text("Technomancer Rune"),
    description = ccb.content.text("This ritual inscribes circuit-like ley-lines into a rune, attuned to Technomancers.  You can use the rune as a catalyst for recipes."),
    valid_targets = { "self" },
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "rune_technomancer",
    extra_spells = { { spell = "eoc_channeling_setup", self = true } },
    shape = "blast",
    base_casting_time = 5000,
    base_energy_cost = 5,
    min_duration = 1,
    max_duration = 2,
    duration_increment = 1,
    difficulty = 0,
    max_level = 0,
    spell_class = "TECHNOMANCER",
    magic_type = "magiclysm_channeling_magic",
    flags = { "CHANNELING_SPELL", "PERMANENT", "NO_LEGS", "CONCENTRATE" },
}
