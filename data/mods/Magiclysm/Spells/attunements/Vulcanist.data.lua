local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vulcanist_pyroclastic_flow_smoke",
    name = ccb.content.text_without_extraction("Pyroclastic Flow Smoke"),
    description = ccb.content.text_without_extraction("Creates smoke in the area.  Subspell; you aren't allowed to see it except in debug mode."),
    effect = "attack",
    shape = "line",
    valid_targets = { "hostile", "ground", "ally" },
    field = "fd_fog",
    max_level = 35,
    min_field_intensity = 1,
    max_field_intensity = 3,
    field_intensity_increment = 2,
    min_aoe = 3,
    max_aoe = 7,
    aoe_increment = 0.12,
}

ccb.content.define_spell {
    id = "lava_bomb_shrapnel",
    shape = "blast",
    effect = "attack",
    damage_type = "cut",
    name = ccb.content.text_without_extraction("Lava Bomb Shrapnel"),
    description = ccb.content.text_without_extraction("This is a sub spell for the Lava Bomb spell."),
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE" },
    valid_targets = { "hostile", "ally", "self", "ground" },
    min_damage = { handler = "wave14a_magiclysm_stat_22", fallback = 0 },
    max_damage = { handler = "wave14a_magiclysm_stat_23", fallback = 0 },
    min_aoe = 1,
    aoe_increment = 0.1,
    max_aoe = 3,
    multiple_projectiles = { handler = "wave14a_magiclysm_stat_10", fallback = 0 },
    max_level = 35,
}
