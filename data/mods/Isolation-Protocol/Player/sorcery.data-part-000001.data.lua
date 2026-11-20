local ccb = require("ccb")

ccb.content.define_spell {
    id = "iso_eldritch_basic_attack",
    name = ccb.content.text("Baleful Flames of Abhorrach"),
    description = ccb.content.text("Summon up a bolt of black flame from the Outer Dark that alternately burns and freezes its target."),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "VERBAL", "SOMATIC", "NO_LEGS", "SILENT", "NO_PROJECTILE" },
    spell_class = "iso_eldritch_sorcery",
    magic_type = "iso_eldritch_sorcery",
    difficulty = 1,
    max_level = 30,
    effect = "attack",
    shape = "blast",
    extra_spells = { { spell = "iso_eldritch_basic_attack_cold_damage" } },
    damage_type = "heat",
    min_damage = { handler = "scaled_iso_eldritch_basic_attack_min_damage", fallback = 2.5 },
    max_damage = { handler = "scaled_iso_eldritch_basic_attack_max_damage", fallback = 5.0 },
    min_range = 8,
    range_increment = 0.25,
    max_range = 25,
    base_energy_cost = 40,
    base_casting_time = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "iso_eldritch_basic_attack_cold_damage",
    name = ccb.content.text_without_extraction("Baleful Flames of Abhorrach Cold Damage"),
    description = ccb.content.text_without_extraction("The cold damage part.  IT's a bug if you have it"),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "NO_LEGS", "SILENT", "NO_PROJECTILE" },
    spell_class = "iso_eldritch_sorcery",
    magic_type = "iso_eldritch_sorcery",
    difficulty = 1,
    max_level = 30,
    effect = "attack",
    shape = "blast",
    damage_type = "cold",
    min_damage = { handler = "scaled_iso_eldritch_basic_attack_min_damage", fallback = 2.5 },
    max_damage = { handler = "scaled_iso_eldritch_basic_attack_max_damage", fallback = 5.0 },
    min_range = 8,
    range_increment = 0.25,
    max_range = 25,
}
