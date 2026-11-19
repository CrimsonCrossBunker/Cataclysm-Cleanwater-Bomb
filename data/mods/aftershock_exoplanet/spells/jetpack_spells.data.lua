local ccb = require("ccb")

ccb.content.define_spell {
    id = "spell_rocket_jump",
    name = ccb.content.text("Rocket Jump"),
    description = ccb.content.text("Take to the skies with a rocket assisted jump or dash.  You might target a hostile creature to perform a powerful rocket kick at the end of the dash.  The rocket pack allows for a brief moment of air control or hovering after a jump."),
    valid_targets = { "hostile", "ground" },
    extra_spells = { { spell = "rocket_jump_levitate", self = true } },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "RANDOM_DAMAGE", "EXTRA_EFFECTS_FIRST" },
    message = "",
    effect = "dash",
    min_damage = 20,
    max_damage = 40,
    shape = "blast",
    min_range = 6,
    max_range = 6,
    spell_class = "NONE",
    difficulty = -20,
    max_level = 1,
    energy_source = "NONE",
}

-- NO_I18N
-- NO_I18N
-- duration is in moves
ccb.content.define_spell {
    id = "rocket_jump_levitate",
    name = ccb.content.text_without_extraction("Rocket Jump Levitation"),
    description = ccb.content.text_without_extraction("Chained before a rocket jump.  Grants a brief instant of levitation to simulate a rocket pack-s limited flying ability."),
    valid_targets = { "self" },
    flags = { "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    effect_data = "afs_rocket_flight",
    shape = "blast",
    affected_bodyparts = { "torso" },
    difficulty = 1,
    max_level = 1,
    min_range = 1,
    max_range = 1,
    min_duration = 150,
    max_duration = 150,
}
