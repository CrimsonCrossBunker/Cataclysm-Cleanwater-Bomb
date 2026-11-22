local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "magus_far_hand_pull_creatures",
    name = ccb.content.text_without_extraction("Sorcerer's Hand Creature"),
    description = ccb.content.text_without_extraction("Pull a target to you."),
    valid_targets = { "ally", "hostile" },
    spell_class = "MAGUS",
    flags = { "CONCENTRATE", "VERBAL", "SOMATIC", "NO_HANDS" },
    difficulty = 2,
    max_level = 10,
    effect = "directed_push",
    shape = "blast",
    min_damage = { handler = "scaled_magus_far_hand_pull_creatures_min_damage", fallback = -0.0 },
    max_damage = { handler = "scaled_magus_far_hand_pull_creatures_min_damage", fallback = -0.0 },
    min_range = { handler = "scaled_magus_far_hand_pull_creatures_min_range", fallback = 3.0 },
    max_range = { handler = "scaled_magus_far_hand_pull_creatures_min_range", fallback = 3.0 },
    magic_type = "magiclysm_generic_magic",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "magus_far_hand_pull_items",
    name = ccb.content.text_without_extraction("Sorcerer's Hand Items"),
    description = ccb.content.text_without_extraction("Pull an items to you."),
    valid_targets = { "ally", "hostile", "item", "ground" },
    spell_class = "MAGUS",
    flags = { "CONCENTRATE", "VERBAL", "SOMATIC", "NO_HANDS" },
    difficulty = 2,
    max_level = 10,
    effect = "pickup",
    shape = "blast",
    min_damage = { handler = "scaled_magus_far_hand_pull_items_min_damage", fallback = 250.0 },
    max_damage = { handler = "scaled_magus_far_hand_pull_items_min_damage", fallback = 250.0 },
    min_range = { handler = "scaled_magus_far_hand_pull_creatures_min_range", fallback = 3.0 },
    max_range = { handler = "scaled_magus_far_hand_pull_creatures_min_range", fallback = 3.0 },
    magic_type = "magiclysm_generic_magic",
}

ccb.content.define_spell {
    id = "magus_far_hand_pull",
    shape = "blast",
    spell_class = "MAGUS",
    magic_type = "magiclysm_evocation_magic",
    name = "Sorcerer's Hand",
    description = "Pull a target or set of items to you.",
    flags = { "EVOCATION_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC", "NO_HANDS" },
    valid_targets = { "self" },
    base_energy_cost = 200,
    final_energy_cost = 50,
    energy_increment = -10,
    difficulty = 2,
    max_level = 10,
    base_casting_time = 150,
    final_casting_time = 50,
    casting_time_increment = -10,
    impact_handler = "w16b_sp_imp_magiclysm_1f1abf99c3e9",
    extra_spells = {
        { spell = "eoc_evocation_setup", self = true },
    },
}
