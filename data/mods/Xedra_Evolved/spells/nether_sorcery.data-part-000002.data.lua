local ccb = require("ccb")

ccb.content.define_spell {
    id = "xe_nether_sorcery_cold_damage_over_time",
    name = ccb.content.text("Bound in Ebon Bands"),
    description = ccb.content.text("Bind a single target in bands of shadow, holding them in place and causing cold damage over time."),
    message = ccb.content.text("You intone the words of the spell."),
    valid_targets = { "hostile", "ground" },
    flags = { "RANDOM_DAMAGE", "RANDOM_DURATION", "VERBAL", "SOMATIC", "NO_LEGS", "LOUD" },
    spell_class = "XE_NETHER_SORCERY",
    magic_type = "xe_nether_sorcery",
    skill = "deduction",
    difficulty = 30,
    max_level = 15,
    effect = "attack",
    effect_data = "effect_xe_nether_sorcery_cold_damage_over_time",
    shape = "blast",
    damage_type = "cold",
    min_dot = { handler = "scaled_xe_nether_sorcery_cold_damage_over_time_min_dot", fallback = 0.3 },
    max_dot = { handler = "scaled_xe_nether_sorcery_cold_damage_over_time_max_dot", fallback = 0.8 },
    min_duration = {
        handler = "scaled_xe_nether_sorcery_cold_damage_over_time_min_duration",
        fallback = 800.0,
    },
    max_duration = {
        handler = "scaled_xe_nether_sorcery_cold_damage_over_time_max_duration",
        fallback = 2000.0,
    },
    min_range = 6,
    range_increment = 0.5,
    max_range = 30,
    base_energy_cost = 2500,
    base_casting_time = 75,
}
