local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wraith_summon_shadow",
    name = ccb.content.text_without_extraction("Wraith Summon Shadow"),
    description = ccb.content.text_without_extraction("Summons hostile shadows."),
    effect = "summon",
    effect_data = "mon_shadow",
    message = "",
    shape = "blast",
    valid_targets = { "self", "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "HOSTILE_SUMMON" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 2,
    max_aoe = 2,
    min_duration = 30000,
    max_duration = 30000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wraith_apply_darkness",
    name = ccb.content.text_without_extraction("Wraith Apply Darkness"),
    description = ccb.content.text_without_extraction("Applies the darkness effect"),
    effect = "attack",
    effect_data = "darkness",
    message = "",
    shape = "blast",
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_range = 35,
    max_range = 35,
    min_duration = 6000,
    max_duration = 6000,
}
