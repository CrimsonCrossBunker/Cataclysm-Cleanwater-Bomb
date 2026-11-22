local ccb = require("ccb")

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
