local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boann_retaliation_mark",
    name = ccb.content.text_without_extraction("Boann's retaliation targeting"),
    valid_targets = { "self", "hostile", "ground", "ally" },
    description = ccb.content.text_without_extraction("Intended to be hidden.  This is how Boann teleport away monsters that hit her."),
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_FAIL" },
    message = "",
    effect = "attack",
    effect_data = "boann_retaliation_mark",
    min_range = 60,
    max_range = 60,
    min_duration = 500,
    max_duration = 500,
    shape = "blast",
}
