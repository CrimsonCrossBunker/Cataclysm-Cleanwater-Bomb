local ccb = require("ccb")

ccb.content.define_spell {
    id = "animist_magic_fissile",
    name = ccb.content.text("Magic Fissile"),
    description = ccb.content.text("I cast Magic… Fissile?  At the darkness?"),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "VERBAL", "SOMATIC", "RANDOM_DAMAGE", "NO_LEGS", "SILENT", "NO_PROJECTILE" },
    extra_spells = {
        { spell = "animist_radiation_bolt", self = false },
        { spell = "eoc_evocation_setup", self = true },
    },
    min_damage = { handler = "scaled_animist_magic_fissile_min_damage", fallback = 0.0 },
    max_damage = { handler = "scaled_animist_magic_fissile_max_damage", fallback = 3.0 },
    damage_type = "necrotic",
    min_range = 8,
    range_increment = 0.8,
    max_range = 20,
    base_energy_cost = 50,
    spell_class = "ANIMIST",
    difficulty = 1,
    max_level = 15,
    base_casting_time = 100,
    magic_type = "magiclysm_evocation_magic",
    shape = "blast",
    effect = "attack",
}
