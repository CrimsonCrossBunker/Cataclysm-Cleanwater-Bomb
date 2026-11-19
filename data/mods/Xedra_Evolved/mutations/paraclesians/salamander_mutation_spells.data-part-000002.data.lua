local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "salamander_smoke_immunity_spell",
    name = ccb.content.text_without_extraction("In a Cloud of Smoke Immunity"),
    description = ccb.content.text_without_extraction("Makes the Salamander immune to smoke so they won't inhale tons of smoke when teleporting.  It's a bug if you have it directly."),
    valid_targets = { "self" },
    skill = "deduction",
    effect = "attack",
    effect_data = "effect_salamander_smoke_immunity",
    shape = "blast",
    min_duration = 300,
    max_duration = 300,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "salamander_smoke_teleport_spell_emit",
    name = ccb.content.text_without_extraction("In a Cloud of Smoke Emit"),
    description = ccb.content.text_without_extraction("Releases the smoke from casting In a Puff of Smoke.  It's a bug if you have it directly."),
    skill = "deduction",
    valid_targets = { "none" },
    effect = "emit",
    effect_data = "emit_smoke_stream",
    shape = "blast",
}
