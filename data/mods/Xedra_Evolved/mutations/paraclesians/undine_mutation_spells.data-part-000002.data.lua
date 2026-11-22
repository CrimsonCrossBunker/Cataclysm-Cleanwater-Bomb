local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "undine_acid_resist_ally_thorns",
    name = ccb.content.text_without_extraction("Caustic Cloak Thorns Spell"),
    description = ccb.content.text_without_extraction("The thorns effect from Caustic Cloak.  It's a bug if you have it directly."),
    effect = "attack",
    shape = "blast",
    flags = { "SILENT", "RANDOM_DAMAGE" },
    min_damage = 2,
    max_damage = 10,
    valid_targets = { "hostile" },
    damage_type = "acid",
    min_range = 1,
    max_range = 1,
}

ccb.content.define_spell {
    id = "undine_acid_resist_ally_spell",
    skill = "deduction",
    shape = "blast",
    effect = "attack",
    effect_data = "effect_undine_acid_resist_ally",
    spell_class = "UNDINE",
    magic_type = "xe_fey_magick",
    name = "Caustic Cloak",
    description = "Weave a cloak of fae magicks around a target, surrounding them with a thin shell of acidic mist.  This protects them somewhat from acid damage and will sometimes damage an attacker as well.",
    teachable = false,
    flags = { "SOMATIC", "VERBAL", "NO_PROJECTILE", "NO_LEGS", "NO_HANDS" },
    valid_targets = { "ally" },
    min_range = 1,
    range_increment = 0.4,
    max_range = 20,
    min_duration = 30000,
    duration_increment = 16500,
    max_duration = 1080000,
    base_energy_cost = 650,
    final_energy_cost = 400,
    energy_increment = -12,
    difficulty = 6,
    max_level = { handler = "wave14a_xedra_evolved_stat_95", fallback = 0 },
    base_casting_time = 450,
}
