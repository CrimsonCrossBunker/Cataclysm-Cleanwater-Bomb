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

ccb.content.define_spell {
    id = "ink_gland_spray_primer",
    shape = "blast",
    spell_class = "NONE",
    name = ccb.content.text_without_extraction("Blinding spray primer"),
    description = ccb.content.text_without_extraction("Blinds a random nearby enemy for a short duration and up an ink_gland_ink status charge."),
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    energy_source = "NONE",
    min_damage = 0,
    max_damage = 0,
    min_range = 1,
    max_range = 1,
    difficulty = -20,
    impact_handler = "w16b_sp_imp_dda_545341de83e1",
}
