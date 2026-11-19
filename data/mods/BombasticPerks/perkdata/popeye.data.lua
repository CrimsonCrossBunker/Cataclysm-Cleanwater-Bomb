local ccb = require("ccb")

ccb.content.define_spell {
    id = "spell_strength_of_spinach",
    name = ccb.content.text("Strength in Spinach"),
    description = ccb.content.text("You gain the strength of a sailor."),
    valid_targets = { "self" },
    min_duration = 6000,
    max_duration = 6000,
    max_level = 1,
    flags = { "SILENT", "SOMATIC", "NO_LEGS", "NO_PROJECTILE" },
    shape = "blast",
    effect = "attack",
    effect_data = "spinach_strength",
}
