local ccb = require("ccb")

-- id retained for legacy reasons
ccb.content.define_spell {
    id = "force_blade",
    name = ccb.content.text("Storm of Force"),
    description = ccb.content.text("You shoot blasts of of concentrated force in a straight line, cutting everything in their path."),
    valid_targets = { "hostile", "ground", "ally" },
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "SOMATIC", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    extra_spells = { { spell = "eoc_evocation_setup", self = true } },
    effect = "attack",
    shape = "line",
    spell_class = "FORCE_MAGE",
    magic_type = "magiclysm_evocation_magic",
    base_casting_time = 250,
    base_energy_cost = 350,
    difficulty = 4,
    max_level = 35,
    min_damage = { handler = "scaled_force_blade_min_damage", fallback = 31.0 },
    max_damage = { handler = "scaled_force_blade_max_damage", fallback = 49.0 },
    damage_type = "cut",
    min_aoe = 1,
    max_aoe = 1,
    min_range = 5,
    max_range = 15,
    range_increment = 1,
}
