local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ink_gland_spray",
    name = ccb.content.text_without_extraction("Blinding spray"),
    description = ccb.content.text_without_extraction("Blinds enemy for a short time."),
    effect = "attack",
    effect_data = "blind",
    shape = "blast",
    valid_targets = { "hostile" },
    min_damage = 1,
    max_damage = 2,
    min_aoe = 1,
    max_aoe = 1,
    min_range = 1,
    max_range = 1,
    min_duration = 300,
    max_duration = 500,
    spell_class = "NONE",
    difficulty = -20,
    flags = {
        "SILENT",
        "NO_LEGS",
        "NO_HANDS",
        "RANDOM_DAMAGE",
        "RANDOM_DURATION",
        "RANDOM_CRITTER",
        "NO_PROJECTILE",
        "NON_MAGICAL",
        "NO_EXPLOSION_SFX",
    },
    energy_source = "NONE",
    damage_type = "biological",
}
