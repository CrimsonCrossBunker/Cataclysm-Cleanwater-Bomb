local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "clair_potion_clairvoyance",
    name = ccb.content.text_without_extraction("[Ψ]Gray Potion Clairvoyance"),
    description = ccb.content.text_without_extraction("The clairvoyance effect from the elixir.  If you have it it's a bug."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    effect = "attack",
    shape = "blast",
    difficulty = 4,
    max_level = 1,
    min_aoe = 20,
    max_aoe = 20,
    field = "fd_clairvoyant",
    min_field_intensity = 1,
    max_field_intensity = 1,
    min_duration = 200,
    max_duration = 200,
}

-- NO_I18N
-- NO_I18N
-- Range here is C conversational range
ccb.content.define_spell {
    id = "clair_group_tactics_aoe",
    name = ccb.content.text_without_extraction("[Ψ]Prescient Tactics AoE"),
    description = ccb.content.text_without_extraction("This provides the buff to your followers.  It's a bug if you have it directly."),
    message = "",
    teachable = false,
    valid_targets = { "ally" },
    flags = { "PSIONIC", "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "effect_clair_group_tactics_other",
    shape = "blast",
    min_aoe = 20,
    max_aoe = 20,
    min_duration = 200,
    max_duration = 200,
}
