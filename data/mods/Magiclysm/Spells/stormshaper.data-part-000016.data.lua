local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "stormshaper_cloak_fog_wonder",
    name = ccb.content.text_without_extraction("Cloak of Fog Wonder"),
    description = ccb.content.text_without_extraction("Places other fog locations nearby.  The number depends on your cloak of fog level."),
    flags = { "WONDER", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    effect = "attack",
    extra_spells = { { spell = "stormshaper_cloak_fog_random", max_level = 20 } },
    shape = "blast",
    min_damage = { handler = "scaled_stormshaper_cloak_fog_wonder_min_damage", fallback = 2.0 },
    max_damage = { handler = "scaled_stormshaper_cloak_fog_wonder_min_damage", fallback = 2.0 },
}
