local ccb = require("ccb")

ccb.content.define_spell {
    id = "magic_missile",
    name = ccb.content.text("Magic Missile"),
    description = ccb.content.text("I cast Magic Missile at the darkness!"),
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "VERBAL", "SOMATIC", "NO_LEGS", "SILENT", "NO_PROJECTILE" },
    extra_spells = { { spell = "eoc_evocation_setup", self = true } },
    min_damage = { handler = "scaled_magic_missile_min_damage", fallback = 0.0 },
    max_damage = { handler = "scaled_magic_missile_max_damage", fallback = 3.0 },
    damage_type = "nether",
    min_range = 8,
    range_increment = 0.8,
    max_range = 20,
    base_energy_cost = 50,
    spell_class = "MAGUS",
    difficulty = 1,
    max_level = 15,
    base_casting_time = 100,
    magic_type = "magiclysm_evocation_magic",
    shape = "blast",
    effect = "attack",
}
