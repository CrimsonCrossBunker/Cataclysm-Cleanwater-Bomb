local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "amalgamation_telekinetic_shielder_shield_other_spell_self_casting",
    name = ccb.content.text_without_extraction("Inertial Barrier Guardian Amalgamation Random Self Spell"),
    description = ccb.content.text_without_extraction("I don't know why this spell is necessary, but it is."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT" },
    effect = "noise",
    min_damage = 0,
    max_damage = 0,
    shape = "blast",
    extra_spells = { { spell = "amalgamation_telekinetic_shielder_shield_other_spell_apply_shield" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "amalgamation_telekinetic_shielder_shield_other_spell_apply_shield",
    name = ccb.content.text_without_extraction("Inertial Barrier Guardian Amalgamation Shield Applicator"),
    description = ccb.content.text_without_extraction("The actual power that applies Inertial Barrier to an ally."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "RANDOM_TARGET", "RANDOM_DURATION" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_inertial_barrier",
    shape = "blast",
    min_range = 25,
    max_range = 25,
    min_duration = 4500,
    max_duration = 7500,
    targeted_species = { "ZOMBIE", "FERAL" },
    ignored_species = { "PSI_NULL" },
}
