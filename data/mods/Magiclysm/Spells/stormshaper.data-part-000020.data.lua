local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "stormshaper_cloak_frog_summon_wonder",
    name = ccb.content.text_without_extraction("Cloak of Frog Wonder"),
    description = ccb.content.text_without_extraction("Places other frog locations nearby.  The number depends on your cloak of frog level."),
    flags = { "TRANSFORMATION_SPELL", "WONDER", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    effect = "attack",
    extra_spells = { { spell = "stormshaper_cloak_frog_summon", max_level = 20 } },
    shape = "blast",
    min_damage = { handler = "scaled_stormshaper_cloak_frog_summon_wonder_min_damage", fallback = 1.0 },
    max_damage = { handler = "scaled_stormshaper_cloak_frog_summon_wonder_min_damage", fallback = 1.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "stormshaper_cloak_frog_summon",
    name = ccb.content.text_without_extraction("Cloak of Frog Summon"),
    description = ccb.content.text_without_extraction("The spell that creates the frogs.  It's a bug if you have it."),
    flags = { "TRANSFORMATION_SPELL", "RANDOM_TARGET", "NO_EXPLOSION_SFX", "SPAWN_GROUP" },
    valid_targets = { "ground", "hostile" },
    message = "",
    effect = "summon",
    effect_data = "GROUP_FROGS_CLOAK",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_range = 5,
    max_range = 25,
    range_increment = 1,
    min_aoe = 4,
    max_aoe = 20,
    aoe_increment = 0.65,
    min_duration = { handler = "scaled_stormshaper_cloak_frog_summon_min_duration", fallback = 15000.0 },
}
