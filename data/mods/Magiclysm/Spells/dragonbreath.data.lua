local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dragon_deep_breath",
    name = ccb.content.text_without_extraction("Take a Deep Breath"),
    description = ccb.content.text_without_extraction("Preps for using dragon breath."),
    flags = { "VERBAL", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 40,
    effect = "attack",
    extra_spells = { { spell = "dragon_deep_breath_self", self = true, max_level = 1 } },
    shape = "blast",
    min_range = 8,
    max_range = 12,
    range_increment = 0.1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dragon_deep_breath_self",
    name = ccb.content.text_without_extraction("Took a Deep Breath"),
    description = ccb.content.text_without_extraction("Grants the effect for a dragon to use deep breath."),
    flags = { "VERBAL", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_dragon_deep_breath",
    shape = "blast",
    min_duration = 100,
    max_duration = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dragon_breath_black",
    name = ccb.content.text_without_extraction("Black Dragons' Breath"),
    description = ccb.content.text_without_extraction("Spews a line of acid from your mouth."),
    valid_targets = { "hostile", "ally", "ground" },
    extra_spells = { { spell = "dragon_breath_black_remove_breath", self = true, max_level = 1 } },
    damage_type = "acid",
    max_level = 40,
    min_damage = 6,
    max_damage = 240,
    damage_increment = 6.0,
    min_range = 8,
    max_range = 12,
    range_increment = 0.1,
    effect = "attack",
    shape = "line",
    field = "fd_acid",
    min_field_intensity = 1,
    max_field_intensity = 4,
    field_chance = 1,
    field_intensity_increment = 0.1,
    flags = { "VERBAL", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "SPLIT_DAMAGE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dragon_breath_black_remove_breath",
    name = ccb.content.text_without_extraction("Remove Deep Breath"),
    description = ccb.content.text_without_extraction("Removes effect for a dragon to use deep breath."),
    flags = { "VERBAL", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "remove_effect",
    effect_data = "effect_dragon_deep_breath",
    shape = "blast",
}
