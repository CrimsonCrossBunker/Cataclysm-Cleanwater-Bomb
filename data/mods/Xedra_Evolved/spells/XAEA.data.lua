local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_motion_vision",
    name = ccb.content.text_without_extraction("Artifact Super Senses"),
    description = ccb.content.text_without_extraction("You can feel any monster in range for a 0,5 - 2 h."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    effect = "attack",
    shape = "blast",
    effect_data = "xe_motion_vision",
    min_duration = 180000,
    max_duration = 720000,
    sound_description = "",
    message = "",
}
