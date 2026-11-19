local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "changeling_autumn_freeze_in_place_remover",
    name = ccb.content.text_without_extraction("Balor's Gaze Remover"),
    description = ccb.content.text_without_extraction("Gets Rid of Balor's Gaze on the target."),
    flags = { "NO_HANDS", "NO_LEGS" },
    magic_type = "xe_fey_seasonal_magick_autumn",
    spell_class = "CHANGELING_SEASONAL_MAGIC_AUTUMN",
    valid_targets = { "hostile", "ally", "ground" },
    teachable = false,
    skill = "gramarye",
    max_level = 1,
    shape = "blast",
    difficulty = 8,
    effect = "remove_effect",
    effect_data = "effect_changeling_autumn_freeze_in_place_target",
    min_aoe = 12,
}
