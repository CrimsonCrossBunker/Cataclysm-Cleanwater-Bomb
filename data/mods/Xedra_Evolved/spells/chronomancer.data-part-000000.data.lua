local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_chronomancer_normalize_time_loop",
    name = ccb.content.text_without_extraction("Unfreeze Time - Loop"),
    description = ccb.content.text_without_extraction("Remove a time loop.  Part of the main unfreeze spell.  Having this spell is a bug."),
    teachable = false,
    valid_targets = { "self", "ally", "ground", "hostile" },
    spell_class = "XEDRA_CHRONOMANCER",
    skill = "deduction",
    flags = {
        "NO_FAIL",
        "NO_HANDS",
        "NO_LEGS",
        "NO_EXPLOSION_SFX",
        "IGNORE_WALLS",
        "NO_PROJECTILE",
        "MUST_HAVE_CLASS_TO_LEARN",
    },
    difficulty = 0,
    max_level = 1,
    effect = "remove_effect",
    effect_data = "effect_xedra_time_loop",
    shape = "blast",
    min_range = 80,
    max_range = 80,
    base_energy_cost = 0,
    base_casting_time = 0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_chronomancer_normalize_time_terrain",
    name = ccb.content.text_without_extraction("Unfreeze Time - Terrain"),
    description = ccb.content.text_without_extraction("Unfreeze terrain from frozen time.  Part of the main unfreeze spell.  Having this spell is a bug."),
    teachable = false,
    valid_targets = { "self", "ally", "ground", "hostile" },
    spell_class = "XEDRA_CHRONOMANCER",
    skill = "deduction",
    flags = {
        "NO_FAIL",
        "NO_HANDS",
        "NO_LEGS",
        "NO_EXPLOSION_SFX",
        "IGNORE_WALLS",
        "NO_PROJECTILE",
        "MUST_HAVE_CLASS_TO_LEARN",
    },
    difficulty = 0,
    max_level = 1,
    effect = "ter_transform",
    effect_data = "xedra_chronomancer_normalize_time_terrain_furn_transform",
    shape = "blast",
    min_range = 80,
    max_range = 80,
    base_energy_cost = 0,
    base_casting_time = 0,
}
