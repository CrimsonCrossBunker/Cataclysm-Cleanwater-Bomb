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

ccb.content.define_spell {
    id = "hidebehind_apply_obscurity_power",
    shape = "blast",
    name = ccb.content.text_without_extraction("Hidebehind Obscurity enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Obscurity when a hostile target is detected."),
    flags = {
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "NO_PROJECTILE",
        "NO_EXPLOSION_SFX",
        "MUST_HAVE_CLASS_TO_LEARN",
        "HIDDEN_SPELL",
    },
    valid_targets = { "hostile" },
    min_range = 60,
    max_range = 60,
    max_level = 1,
    impact_handler = "w16b_sp_imp_mindovermatter_acd103bac23e",
}

ccb.content.define_spell {
    id = "teleporter_breach_lab_devourer",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "TELEPORTER",
    name = ccb.content.text_without_extraction("[Ψ]Breach Melded Task Force"),
    description = ccb.content.text_without_extraction("Open a portal to the Nether and summon monsters, if you're also a monster.  This will not end badly for you because they're all on your side."),
    message = "",
    teachable = false,
    flags = { "PSIONIC", "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self", "hostile" },
    min_damage = 1,
    min_range = 5,
    range_increment = 1,
    max_range = 80,
    max_level = 30,
    impact_handler = "w16b_sp_imp_mindovermatter_e35fce980f9f",
}

ccb.content.define_spell {
    id = "amalgamation_telekinetic_shielder_shield_other_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("Inertial Barrier Guardian Amalgamation Shield Detector"),
    description = ccb.content.text_without_extraction("Preps for using Inertial Barrier when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    min_damage = 0,
    max_damage = 0,
    min_range = 20,
    max_range = 20,
    max_level = 1,
    impact_handler = "w16b_sp_imp_mindovermatter_6c77438a9689",
}
