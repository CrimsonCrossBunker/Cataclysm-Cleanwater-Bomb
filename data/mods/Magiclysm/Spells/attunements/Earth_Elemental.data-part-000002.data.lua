local ccb = require("ccb")

ccb.content.define_spell {
    id = "rock_blast",
    name = ccb.content.text("Rock Blast"),
    description = ccb.content.text("Fire three large rocks at an enemy, causing blunt damage and knocking it back."),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    effect = "attack",
    shape = "blast",
    max_level = 35,
    min_damage = { handler = "scaled_rock_blast_min_damage", fallback = 6.0 },
    max_damage = { handler = "scaled_rock_blast_max_damage", fallback = 14.0 },
    min_range = 8,
    max_range = 15,
    range_increment = 0.2,
    sound_id = "earth_spell",
    sound_variant = "strong",
    energy_source = "STAMINA",
    magic_type = "magiclysm_evocation_magic",
    spell_class = "EARTH_ELEMENTAL",
    damage_type = "bash",
    base_energy_cost = 5000,
    base_casting_time = 200,
    final_casting_time = 50,
    casting_time_increment = -5,
    extra_spells = {
        { spell = "single_rock_blast" },
        { spell = "single_rock_blast" },
        { spell = "rock_blast_push" },
        { spell = "eoc_evocation_setup", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "single_rock_blast",
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    name = ccb.content.text_without_extraction("Single Rock Blast"),
    description = ccb.content.text_without_extraction("A single portion of the rock blast spell."),
    valid_targets = { "hostile" },
    effect = "attack",
    shape = "blast",
    max_level = 35,
    min_damage = { handler = "scaled_rock_blast_min_damage", fallback = 6.0 },
    max_damage = { handler = "scaled_rock_blast_max_damage", fallback = 14.0 },
    min_range = 8,
    max_range = 15,
    range_increment = 0.2,
    damage_type = "bash",
    sound_id = "earth_spell",
    sound_variant = "strong",
}
