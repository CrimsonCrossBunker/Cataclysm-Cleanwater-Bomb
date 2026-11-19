local ccb = require("ccb")

ccb.content.define_spell {
    id = "spawn_blackfire_shield",
    name = ccb.content.text("Spawn Blackfire Shield"),
    description = ccb.content.text("Creates a shield."),
    valid_targets = { "self" },
    flags = { "VERBAL", "NO_FAIL", "CONCENTRATE", "SOMATIC", "PERMANENT_ALL_LEVELS", "NO_EXPLOSION_SFX" },
    min_range = 0,
    max_range = 0,
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "iso_blackfire_shield",
    shape = "blast",
    max_level = 1,
}
