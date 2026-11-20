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
