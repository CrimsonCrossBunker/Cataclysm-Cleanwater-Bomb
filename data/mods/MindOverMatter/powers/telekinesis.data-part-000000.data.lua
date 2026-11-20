local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_item_pull_real",
    name = ccb.content.text_without_extraction("[Ψ]Far Hand Pull Items Real"),
    description = ccb.content.text_without_extraction("The actual effect that causes the far hand.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "item", "ground", "self", "ally", "hostile" },
    skill = "metaphysics",
    flags = { "PSIONIC", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    difficulty = 1,
    max_level = { handler = "scale_telekinetic_item_pull_real_max_level", fallback = 0 },
    effect = "pickup",
    shape = "blast",
    min_damage = { handler = "scale_telekinetic_item_pull_real_min_damage", fallback = 50.0 },
    max_damage = { handler = "scale_telekinetic_item_pull_real_max_damage", fallback = 100.0 },
    min_aoe = { handler = "scale_telekinetic_item_pull_real_min_aoe", fallback = 0.0 },
    max_aoe = { handler = "scale_telekinetic_item_pull_real_min_aoe", fallback = 0.0 },
    min_range = { handler = "scale_telekinetic_item_pull_real_min_range", fallback = 0.0 },
    max_range = { handler = "scale_telekinetic_item_pull_real_min_range", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_item_push_real",
    name = ccb.content.text_without_extraction("[Ψ]Far Hand Push Items Real"),
    description = ccb.content.text_without_extraction("The actual effect that causes the far hand.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "item", "ground" },
    skill = "metaphysics",
    flags = { "PSIONIC", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    difficulty = 1,
    max_level = { handler = "scale_telekinetic_item_pull_real_max_level", fallback = 0 },
    effect = "directed_push",
    shape = "blast",
    min_damage = { handler = "scale_telekinetic_item_push_real_min_damage", fallback = 0.0 },
    max_damage = { handler = "scale_telekinetic_item_push_real_max_damage", fallback = 0.0 },
    min_range = { handler = "scale_telekinetic_item_push_real_min_range", fallback = 0.0 },
    max_range = { handler = "scale_telekinetic_item_push_real_max_range", fallback = 0.0 },
}
