local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "changeling_summer_ring_of_flames_actual_flames_summer_spell",
    name = ccb.content.text_without_extraction("Ring of Champions Summer Flames"),
    description = ccb.content.text_without_extraction("The spell that creates the actual flames in summer"),
    message = "",
    teachable = false,
    valid_targets = { "hostile", "ground", "ally" },
    spell_class = "CHANGELING_SEASONAL_MAGIC_SUMMER",
    magic_type = "xe_fey_seasonal_magick_summer",
    skill = "gramarye",
    flags = { "SILENT" },
    effect = "attack",
    shape = "blast",
    min_aoe = 6,
    max_aoe = 6,
    field = "fd_fire",
    min_field_intensity = 3,
    max_field_intensity = 3,
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "changeling_summer_ring_of_flames_actual_flames_non_summer_spell",
    name = ccb.content.text_without_extraction("Ring of Champions Non_Summer Flames"),
    description = ccb.content.text_without_extraction("The spell that creates the actual flames not in summer"),
    message = "",
    teachable = false,
    valid_targets = { "hostile", "ground", "ally" },
    spell_class = "CHANGELING_SEASONAL_MAGIC_SUMMER",
    magic_type = "xe_fey_seasonal_magick_summer",
    skill = "gramarye",
    flags = { "SILENT" },
    effect = "attack",
    shape = "blast",
    min_aoe = 6,
    max_aoe = 6,
    field = "fd_fire",
    min_field_intensity = 2,
    max_field_intensity = 2,
    field_chance = 1,
}
