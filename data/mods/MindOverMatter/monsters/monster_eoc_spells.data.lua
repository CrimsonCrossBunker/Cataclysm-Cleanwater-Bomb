local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eater_drain_mana",
    name = ccb.content.text_without_extraction("[Ψ]Eater Drain Mana"),
    description = ccb.content.text_without_extraction("Eater's spell to drain mana.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "recover_energy",
    effect_data = "MANA",
    shape = "blast",
    max_level = 1,
    min_damage = -150,
    min_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eater_drain_stamina",
    name = ccb.content.text_without_extraction("[Ψ]Eater Drain Stamina"),
    description = ccb.content.text_without_extraction("Eater's spell to drain stamina.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "recover_energy",
    effect_data = "STAMINA",
    extra_spells = { { spell = "eater_drain_sleepiness", self = false, max_level = 3 } },
    shape = "blast",
    max_level = 1,
    min_damage = -200,
    min_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eater_drain_sleepiness",
    name = ccb.content.text_without_extraction("[Ψ]Eater Drain Sleepiness"),
    description = ccb.content.text_without_extraction("Eater's spell to drain sleepiness.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "recover_energy",
    effect_data = "SLEEPINESS",
    shape = "blast",
    max_level = 1,
    min_damage = -2,
    min_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eater_drain_health",
    name = ccb.content.text_without_extraction("[Ψ]Eater Drain Stamina"),
    description = ccb.content.text_without_extraction("Eater's spell to drain health.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE" },
    effect = "attack",
    shape = "blast",
    damage_type = "pure",
    max_level = 1,
    min_damage = 1,
    max_damage = 2,
    min_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_power_draining_electric_monster",
    name = ccb.content.text_without_extraction("[Ψ]Electrokinetic Power Draining monster attack"),
    description = ccb.content.text_without_extraction("Gremlin's power to damage electric monsters.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE" },
    effect = "attack",
    shape = "blast",
    damage_type = "pure",
    max_level = 1,
    min_damage = 10,
    max_damage = 55,
}

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

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "silent_one_polymorph_to_hostile",
    name = ccb.content.text_without_extraction("[Ψ]Silent One polymorph"),
    description = ccb.content.text_without_extraction("Silent One' polymorphing to hostile.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    difficulty = 8,
    max_level = 30,
    effect = "targeted_polymorph",
    effect_data = "mon_nether_silent_one_aggressive",
    shape = "blast",
    min_damage = 500,
    max_damage = 500,
    targeted_monsters = { "mon_nether_silent_one_passive" },
}

ccb.content.define_spell {
    id = "silent_one_drain_monster",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Silent One Draining attack"),
    description = ccb.content.text_without_extraction("Silent One's draining attack.  It's a bug if you have it."),
    message = "",
    flags = { "NO_EXPLOSION_SFX", "SILENT" },
    valid_targets = { "hostile" },
    min_range = 15,
    max_range = 15,
    impact_handler = "w16b_sp_imp_mindovermatter_cab969960e4d",
}

ccb.content.define_spell {
    id = "silent_one_detect_psionic_activity",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Silent One Detect Psi"),
    description = ccb.content.text_without_extraction("Silent One's detecting of psionic activity.  It's a bug if you have it."),
    message = "",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    valid_targets = { "ally", "hostile", "self" },
    min_aoe = 45,
    max_aoe = 45,
    impact_handler = "w16b_sp_imp_mindovermatter_d8745b22534f",
}

ccb.content.define_spell {
    id = "silent_one_detect_psionic_activity_aggressive",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Silent One Detect Psi Aggressive"),
    description = ccb.content.text_without_extraction("Silent One's detecting of psionic activity when it's already angry.  It's a bug if you have it."),
    message = "",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    valid_targets = { "ally", "hostile", "self" },
    min_aoe = 15,
    max_aoe = 15,
    impact_handler = "w16b_sp_imp_mindovermatter_ec7662648390",
}

ccb.content.define_spell {
    id = "null_break_concentration_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Breaker end powers"),
    description = ccb.content.text_without_extraction("Breaker's power that ends concentration.  It's a bug if you have it."),
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_damage = 1,
    max_damage = 2,
    min_range = 25,
    max_level = 1,
    impact_handler = "w16b_sp_imp_mindovermatter_ec64e1dc6ea8",
}

ccb.content.define_spell {
    id = "clairsentient_discern_weakness_monster",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Discern Weakness Triffid"),
    description = ccb.content.text_without_extraction("The triffid lays your weak points bare and shares them with others through the heartmind.  It's a bug if you have this."),
    message = "",
    teachable = false,
    flags = {
        "CONCENTRATE",
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "IGNORE_WALLS",
        "RANDOM_DURATION",
        "NO_EXPLOSION_SFX",
    },
    valid_targets = { "hostile" },
    min_range = 3,
    range_increment = 1,
    max_range = 100,
    max_level = 100,
    impact_handler = "w16b_sp_imp_mindovermatter_78768132e537",
}

ccb.content.define_spell {
    id = "teleporter_triffid_summon_allies",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Teleporter Triffid Summon Allies"),
    description = ccb.content.text_without_extraction("The triffid uses its connection to the heartmind to teleport in guards around an intruder.  If you see this, it's a bug."),
    message = "",
    teachable = false,
    flags = { "PSIONIC", "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    valid_targets = { "hostile" },
    min_range = 3,
    range_increment = 1,
    max_range = 23,
    max_level = 20,
    impact_handler = "w16b_sp_imp_mindovermatter_dfc2bbf9a0c3",
}

ccb.content.define_spell {
    id = "electrokinetic_paralysis_monster",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Neural Spasms Monster"),
    description = ccb.content.text_without_extraction("Cause an electrical burst in the target's nervous system, stunning them briefly."),
    message = "",
    teachable = false,
    flags = { "PSIONIC", "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    valid_targets = { "hostile", "ally" },
    min_range = 3,
    range_increment = 1,
    max_range = 23,
    min_duration = 150,
    max_duration = 400,
    max_level = 20,
    impact_handler = "w16b_sp_imp_mindovermatter_d5b58d782a67",
}

ccb.content.define_spell {
    id = "electrokinetic_power_draining",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Electrokinetic Power Draining Spell"),
    description = ccb.content.text_without_extraction("The monster uses its powers to suck the energy out of battery devices.  If you see this, it's a bug."),
    message = "",
    teachable = false,
    flags = {
        "PSIONIC",
        "CONCENTRATE",
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "RANDOM_AOE",
        "IGNORE_WALLS",
    },
    valid_targets = { "self", "ally", "hostile" },
    min_range = 0,
    max_range = 0,
    min_aoe = 5,
    max_aoe = 25,
    max_level = 20,
    impact_handler = "w16b_sp_imp_mindovermatter_f76349762c25",
}

ccb.content.define_spell {
    id = "eater_drain_monster",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Essence Drain"),
    description = ccb.content.text_without_extraction("Eater's draining attack.  It's a bug if you have it."),
    message = "",
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 30,
    difficulty = 1,
    max_level = 20,
    impact_handler = "w16b_sp_imp_mindovermatter_387ee7a2aac4",
}

ccb.content.define_spell {
    id = "eater_drain_monster_close_range",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Essence Drain"),
    description = ccb.content.text_without_extraction("Eater's draining attack.  It's a bug if you have it."),
    message = "",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 30,
    difficulty = 1,
    max_level = 20,
    impact_handler = "w16b_sp_imp_mindovermatter_387ee7a2aac4",
}
