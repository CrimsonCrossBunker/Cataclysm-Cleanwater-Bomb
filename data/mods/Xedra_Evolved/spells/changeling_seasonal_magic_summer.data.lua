local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "changeling_summer_powerful_sunlight_spell_sundeath_self_damage",
    name = ccb.content.text_without_extraction("Helios's Wrath Sundeath damage"),
    description = ccb.content.text_without_extraction("Used because auras are not currently possible.  Causes enemies with the SUNDEATH flag to burn."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_LEGS", "SPLIT_DAMAGE" },
    magic_type = "xe_fey_seasonal_magick_summer",
    spell_class = "CHANGELING_SEASONAL_MAGIC_SUMMER",
    valid_targets = { "self" },
    teachable = false,
    skill = "gramarye",
    max_level = 1,
    shape = "blast",
    effect = "attack",
    damage_type = "pure",
    min_dot = 75,
    max_dot = 75,
    min_duration = 300,
    max_duration = 300,
}
