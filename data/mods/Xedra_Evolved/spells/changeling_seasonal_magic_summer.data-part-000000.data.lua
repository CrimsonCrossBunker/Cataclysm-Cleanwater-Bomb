local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "changeling_summer_lightning_bolt_from_storm_spell_ter_transform",
    name = ccb.content.text_without_extraction("Fist of Taranis Ter Transform 1"),
    description = ccb.content.text_without_extraction("The actual spell that casts the Fist of Taranis crater.  It's a bug if you have it directly."),
    message = "",
    teachable = false,
    valid_targets = { "ground" },
    flags = { "LOUD" },
    effect = "ter_transform",
    effect_data = "ter_sylph_massive_lightning",
    shape = "blast",
    min_range = 25,
    max_range = 25,
    min_aoe = 1,
    max_aoe = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "changeling_summer_lightning_bolt_from_storm_spell_ter_transform_center",
    name = ccb.content.text_without_extraction("Fist of Taranis Ter Transform 2"),
    description = ccb.content.text_without_extraction("The actual spell that casts the Fist of Taranis crater.  It's a bug if you have it directly."),
    message = "",
    teachable = false,
    valid_targets = { "ground" },
    flags = { "LOUD" },
    effect = "ter_transform",
    effect_data = "ter_sylph_massive_lightning",
    shape = "blast",
    min_range = 25,
    max_range = 25,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "changeling_summer_lightning_bolt_from_storm_spell_start_fire",
    name = ccb.content.text_without_extraction("Fist of Taranis Monster Start Fire"),
    description = ccb.content.text_without_extraction("The actual spell that Starts a fire at the impact point.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "ground" },
    flags = { "NO_EXPLOSION_SFX" },
    effect = "area_pull",
    shape = "blast",
    min_range = 25,
    max_range = 25,
    field = "fd_fire",
    min_field_intensity = 3,
    max_field_intensity = 3,
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "changeling_summer_lightning_bolt_from_storm_spell_push_enemies",
    name = ccb.content.text_without_extraction("Fist of Taranis Monster Push"),
    description = ccb.content.text_without_extraction("The actual spell that casts the Fist of Heaven's Fury shove.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile" },
    flags = { "NO_EXPLOSION_SFX", "RANDOM_AOE" },
    effect = "area_push",
    shape = "blast",
    min_range = 25,
    max_range = 25,
    min_aoe = 1,
    max_aoe = 4,
}
