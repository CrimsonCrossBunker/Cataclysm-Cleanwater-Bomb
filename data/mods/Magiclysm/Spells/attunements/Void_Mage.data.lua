local ccb = require("ccb")

ccb.content.define_spell {
    id = "voidmage_final_grasp",
    name = ccb.content.text("Final Grasp"),
    description = ccb.content.text("In the end, everything succumbs to the grasp of nothingness and stasis.  This spell gives the target a foretaste of that."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "SILENT", "SOMATIC", "IGNORE_WALLS", "NO_LEGS" },
    min_damage = 0,
    max_damage = 0,
    min_range = 5,
    max_range = 25,
    range_increment = 0.7,
    damage_type = "necrotic",
    min_dot = 5,
    max_dot = 25,
    dot_increment = 0.75,
    max_level = 35,
    min_duration = 500,
    max_duration = 5000,
    duration_increment = 130,
    spell_class = "VOID_MAGE",
    base_casting_time = 200,
    magic_type = "magiclysm_evocation_magic",
    base_energy_cost = 300,
    final_energy_cost = 150,
    energy_increment = -5,
    difficulty = 9,
    extra_spells = {
        { spell = "voidmage_final_grasp_slowdown" },
        { spell = "eoc_evocation_setup", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "voidmage_final_grasp_slowdown",
    name = ccb.content.text_without_extraction("Final Grasp Slowdown"),
    description = ccb.content.text_without_extraction("Removes some moves from an enemy.  Subspell; you aren't allowed to see it except in debug mode."),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL" },
    effect = "mod_moves",
    shape = "blast",
    max_level = 35,
    min_damage = -100,
    max_damage = -3000,
    damage_increment = -85,
}

ccb.content.define_spell {
    id = "voidmage_horizon_vortex",
    name = ccb.content.text("Horizon Vortex"),
    description = ccb.content.text("Creates a chaotic energy field that disrupts enemies inside it.  It is rather random, and its effects can range from almost nothing to killing all hostiles in the area."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ground" },
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "SILENT", "SOMATIC", "WONDER", "NO_LEGS", "RANDOM_DAMAGE" },
    min_damage = 5,
    max_damage = 20,
    min_range = 5,
    max_range = 20,
    range_increment = 0.4,
    max_level = 35,
    spell_class = "VOID_MAGE",
    base_casting_time = 1200,
    final_casting_time = 600,
    casting_time_increment = -15,
    magic_type = "magiclysm_evocation_magic",
    base_energy_cost = 1600,
    final_energy_cost = 1000,
    energy_increment = -15,
    difficulty = 10,
    extra_spells = {
        { spell = "horizon_vortex_fire" },
        { spell = "horizon_vortex_acid" },
        { spell = "horizon_vortex_bash" },
        { spell = "horizon_vortex_nether" },
        { spell = "horizon_vortex_cold" },
        { spell = "horizon_vortex_cut" },
        { spell = "horizon_vortex_electric" },
        { spell = "horizon_vortex_stab" },
    },
}

-- NO_I18N
ccb.content.define_spell {
    id = "horizon_vortex_fire",
    copy_from = "horizon_vortex_abstract",
    name = ccb.content.text_without_extraction("Horizon Vortex Heat Damage"),
    damage_type = "heat",
    extend_flags = { "RANDOM_DAMAGE" },
}

-- NO_I18N
ccb.content.define_spell {
    id = "horizon_vortex_acid",
    copy_from = "horizon_vortex_abstract",
    name = ccb.content.text_without_extraction("Horizon Vortex Acid Damage"),
    damage_type = "acid",
    extend_flags = { "RANDOM_DAMAGE" },
}

-- NO_I18N
ccb.content.define_spell {
    id = "horizon_vortex_bash",
    copy_from = "horizon_vortex_abstract",
    name = ccb.content.text_without_extraction("Horizon Vortex Light Damage"),
    damage_type = "light",
    extend_flags = { "RANDOM_DAMAGE" },
}

-- NO_I18N
ccb.content.define_spell {
    id = "horizon_vortex_nether",
    copy_from = "horizon_vortex_abstract",
    name = ccb.content.text_without_extraction("Horizon Vortex Pure Damage"),
    damage_type = "nether",
    extend_flags = { "RANDOM_DAMAGE" },
}

-- NO_I18N
ccb.content.define_spell {
    id = "horizon_vortex_cold",
    copy_from = "horizon_vortex_abstract",
    name = ccb.content.text_without_extraction("Horizon Vortex Cold Damage"),
    damage_type = "cold",
    max_level = 35,
    extend_flags = { "RANDOM_DAMAGE" },
}

-- NO_I18N
ccb.content.define_spell {
    id = "horizon_vortex_cut",
    copy_from = "horizon_vortex_abstract",
    name = ccb.content.text_without_extraction("Horizon Vortex Necrotic Damage"),
    damage_type = "necrotic",
    max_level = 35,
    extend_flags = { "RANDOM_DAMAGE" },
}

-- NO_I18N
ccb.content.define_spell {
    id = "horizon_vortex_electric",
    copy_from = "horizon_vortex_abstract",
    name = ccb.content.text_without_extraction("Horizon Vortex Electric Damage"),
    damage_type = "electric",
    max_level = 35,
    extend_flags = { "RANDOM_DAMAGE" },
}

-- NO_I18N
ccb.content.define_spell {
    id = "horizon_vortex_stab",
    copy_from = "horizon_vortex_abstract",
    name = ccb.content.text_without_extraction("Horizon Vortex Poison Damage"),
    damage_type = "poison",
    max_level = 35,
    extend_flags = { "RANDOM_DAMAGE" },
}

ccb.content.define_spell {
    abstract = "horizon_vortex_abstract",
    shape = "blast",
    effect = "attack",
    name = ccb.content.text_without_extraction("Horizon Vortex Abstract"),
    description = ccb.content.text_without_extraction("Causes some damage in the Horizon Vortex spell.  Subspell; you aren't allowed to see it except in debug mode."),
    message = "",
    flags = { "NO_PROJECTILE", "LOUD", "RANDOM_TARGET" },
    valid_targets = { "hostile" },
    min_damage = { handler = "wave14a_magiclysm_stat_20", fallback = 0 },
    max_damage = { handler = "wave14a_magiclysm_stat_21", fallback = 0 },
    min_range = 10,
    range_increment = 0.45,
    max_range = 25,
}
