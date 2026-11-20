local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "animist_mass_hiding_self",
    name = ccb.content.text_without_extraction("A Shadow in the Crowd Self"),
    description = ccb.content.text_without_extraction("Puts an effect on you so anyone affected by A Shadow in the Crowd knows to ignore you.  It's a bug if you have this directly."),
    message = "",
    teachable = false,
    valid_targets = { "self" },
    flags = { "ENERVATION_SPELL", "SILENT", "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    effect_data = "telepathic_ignorance_self",
    shape = "blast",
    min_duration = { handler = "scaled_animist_mass_hiding_self_min_duration", fallback = 3000.0 },
    max_duration = { handler = "scaled_animist_mass_hiding_self_min_duration", fallback = 3000.0 },
}
