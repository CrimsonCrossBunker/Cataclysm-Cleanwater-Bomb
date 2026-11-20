local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "nether_attunement_everyone_downed",
    name = ccb.content.text_without_extraction("Nether Attunement Everyone Downed"),
    valid_targets = { "self", "ally", "hostile" },
    description = ccb.content.text_without_extraction("Knocks you and everyone else nearby off their feet when you use your powers."),
    flags = { "PSIONIC", "SILENT", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    effect = "attack",
    effect_data = "downed",
    shape = "blast",
    extra_spells = { { spell = "nether_attunement_everyone_dazed", self = true } },
    min_aoe = { handler = "scale_nether_attunement_everyone_downed_min_aoe", fallback = 2.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "nether_attunement_everyone_dazed",
    name = ccb.content.text_without_extraction("Nether Attunement Everyone Dazed"),
    valid_targets = { "self", "ally", "hostile" },
    description = ccb.content.text_without_extraction("Dazes you and everyone else nearby when you use your powers."),
    flags = { "PSIONIC", "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DURATION", "IGNORE_WALLS" },
    effect = "attack",
    effect_data = "psi_dazed",
    shape = "blast",
    min_aoe = { handler = "scale_nether_attunement_everyone_downed_min_aoe", fallback = 2.0 },
    min_duration = 200,
    max_duration = 1500,
}
