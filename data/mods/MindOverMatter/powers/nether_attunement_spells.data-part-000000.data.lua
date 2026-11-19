local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "nether_attunement_vomit",
    name = ccb.content.text_without_extraction("Nether Attunement Vomit"),
    valid_targets = { "self" },
    description = ccb.content.text_without_extraction("Vomits when you use your powers."),
    flags = { "SILENT" },
    effect = "vomit",
    shape = "blast",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "nether_attunement_cold_chill",
    name = ccb.content.text_without_extraction("Nether Attunement Cold Chill"),
    valid_targets = { "self" },
    description = ccb.content.text_without_extraction("Drops the temperature when you use your powers."),
    flags = { "PSIONIC", "SILENT", "NO_EXPLOSION_SFX" },
    message = "",
    shape = "blast",
    effect = "emit",
    effect_data = "emit_nether_chill",
}
