local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEP_EVIL_SPELL",
    name = ccb.content.text_without_extraction("EEEEEEVVVVVIIIIILLLL!"),
    description = ccb.content.text_without_extraction("You debugged in this spell!  It makes you evil for 30 minutes."),
    valid_targets = { "hostile", "ally", "self" },
    effect = "attack",
    flags = { "NO_PROJECTILE" },
    shape = "blast",
    effect_data = "evil",
    min_duration = 180000,
    max_duration = 180000,
}
