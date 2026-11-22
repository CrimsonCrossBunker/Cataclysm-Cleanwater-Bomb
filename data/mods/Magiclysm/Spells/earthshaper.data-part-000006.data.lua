local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eshaper_spawn_hammer",
    name = ccb.content.text_without_extraction("Utility Molding (Hammer)"),
    description = ccb.content.text_without_extraction("Spawn the Utility molding hammer.  It's a bug if you have this spell directly."),
    valid_targets = { "self" },
    flags = { "CONJURATION_SPELL", "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "eshaper_hammer",
    shape = "blast",
    min_duration = { handler = "scaled_eshaper_spawn_hammer_min_duration", fallback = 0.0 },
    max_duration = { handler = "scaled_eshaper_spawn_hammer_min_duration", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eshaper_spawn_pickaxe",
    name = ccb.content.text_without_extraction("Utility Molding (Pickaxe)"),
    description = ccb.content.text_without_extraction("Spawn the Utility molding pickaxe.  It's a bug if you have this spell directly."),
    valid_targets = { "self" },
    flags = { "CONJURATION_SPELL", "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "eshaper_pickaxe",
    shape = "blast",
    min_duration = { handler = "scaled_eshaper_spawn_hammer_min_duration", fallback = 0.0 },
    max_duration = { handler = "scaled_eshaper_spawn_pickaxe_max_duration", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eshaper_spawn_axe",
    name = ccb.content.text_without_extraction("Utility Molding (Axe)"),
    description = ccb.content.text_without_extraction("Spawn the Utility molding axe.  It's a bug if you have this spell directly."),
    valid_targets = { "self" },
    flags = { "CONJURATION_SPELL", "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "eshaper_ax",
    shape = "blast",
    min_duration = { handler = "scaled_eshaper_spawn_hammer_min_duration", fallback = 0.0 },
    max_duration = { handler = "scaled_eshaper_spawn_pickaxe_max_duration", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eshaper_spawn_knife",
    name = ccb.content.text_without_extraction("Utility Molding (Knife)"),
    description = ccb.content.text_without_extraction("Spawn the Utility molding knife.  It's a bug if you have this spell directly."),
    valid_targets = { "self" },
    flags = { "CONJURATION_SPELL", "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "eshaper_knife",
    shape = "blast",
    min_duration = { handler = "scaled_eshaper_spawn_pickaxe_max_duration", fallback = 0.0 },
    max_duration = { handler = "scaled_eshaper_spawn_pickaxe_max_duration", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eshaper_spawn_shovel",
    name = ccb.content.text_without_extraction("Utility Molding (Shovel)"),
    description = ccb.content.text_without_extraction("Spawn the Utility molding shovel.  It's a bug if you have this spell directly."),
    valid_targets = { "self" },
    flags = { "CONJURATION_SPELL", "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "eshaper_shovel",
    shape = "blast",
    min_duration = { handler = "scaled_eshaper_spawn_shovel_min_duration", fallback = 0.0 },
    max_duration = { handler = "scaled_eshaper_spawn_shovel_min_duration", fallback = 0.0 },
}

ccb.content.define_spell {
    id = "eshaper_spawn_tools",
    shape = "blast",
    spell_class = "EARTHSHAPER",
    magic_type = "magiclysm_conjuration_magic",
    name = "Utility Molding",
    description = "Shape the basic working tools, using your own magic abilities and earth nearby.  Activate to change the shape of a tool.",
    flags = { "CONJURATION_SPELL", "SOMATIC", "LOUD" },
    valid_targets = { "self" },
    min_damage = 1,
    max_damage = 1,
    min_duration = 576000,
    duration_increment = 576000,
    max_duration = 8640000,
    base_energy_cost = 600,
    final_energy_cost = 200,
    energy_increment = -30,
    difficulty = 2,
    max_level = 14,
    base_casting_time = 360000,
    final_casting_time = 90000,
    casting_time_increment = -18000,
    impact_handler = "w16b_sp_imp_magiclysm_ea149b70b466",
    extra_spells = {
        { spell = "eoc_summon_setup", self = true },
    },
}
