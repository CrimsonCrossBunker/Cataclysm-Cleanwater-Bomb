local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- Ideally range would scale with power level, but there would need to be a way to detect nearby allies first instead of just any ally in the bubble.
ccb.content.define_spell {
    id = "telepathic_network_real",
    name = ccb.content.text_without_extraction("[Ψ]Network Effect Real"),
    description = ccb.content.text_without_extraction("The actual power that implements the Network Effect.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "self", "ally" },
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    difficulty = 9,
    effect = "attack",
    effect_data = "effect_telepath_network_effect",
    shape = "blast",
    min_aoe = 60,
    max_aoe = 60,
    min_duration = { handler = "scale_telepathic_network_real_min_duration", fallback = 0.0 },
    max_duration = { handler = "scale_telepathic_network_real_max_duration", fallback = 0.0 },
}
