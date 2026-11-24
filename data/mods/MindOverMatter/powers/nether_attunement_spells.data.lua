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

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "nether_attunement_nether_lightning",
    name = ccb.content.text_without_extraction("Nether Attunement Lightning All Around"),
    valid_targets = { "self", "ground", "ally", "hostile" },
    description = ccb.content.text_without_extraction("Unleashes a blast of lightning everywhere around."),
    message = "",
    flags = { "PSIONIC", "SILENT", "NO_EXPLOSION_SFX", "RANDOM_AOE", "IGNORE_WALLS" },
    effect = "attack",
    shape = "blast",
    min_aoe = 5,
    max_aoe = 20,
    field = "fd_electricity",
    min_field_intensity = 4,
    max_field_intensity = 7,
    field_chance = 2,
}
