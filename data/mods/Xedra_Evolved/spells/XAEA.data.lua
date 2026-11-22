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

ccb.content.define_spell {
    id = "XAEA_mod_moves",
    shape = "blast",
    effect = "mod_moves",
    damage_type = "bash",
    name = ccb.content.text_without_extraction("Artifact Add Moves"),
    description = ccb.content.text_without_extraction("Gives roughly 15-25 seconds of free actions.  Inverse to current speed compared to 100."),
    message = "The world around you silently stops.",
    sound_description = "",
    flags = { "SILENT", "RANDOM_DAMAGE", "IGNORE_WALLS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_damage = { handler = "wave14a_xedra_evolved_stat_214", fallback = 0 },
    max_damage = { handler = "wave14a_xedra_evolved_stat_215", fallback = 0 },
}
