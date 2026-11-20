local ccb = require("ccb")

ccb.content.define_spell {
    id = "railgun",
    name = ccb.content.text("Railgun"),
    description = ccb.content.text("Magnetize a bullet, and fire it at supersonic speeds by applying an opposite magnetic force to the bullet.  Leaves a trail of sparks"),
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "LOUD", "SOMATIC", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    spell_class = "MAGNETISM_MAGE",
    magic_type = "magiclysm_evocation_magic",
    damage_type = "bullet",
    effect = "attack",
    shape = "blast",
    max_level = 35,
    components = "railgun_bullet",
    min_damage = { handler = "scaled_railgun_min_damage", fallback = 65.0 },
    max_damage = { handler = "scaled_railgun_max_damage", fallback = 80.0 },
    min_range = 20,
    max_range = 20,
    base_casting_time = 400,
    base_energy_cost = 600,
    extra_spells = { { spell = "railgun_sparks" }, { spell = "eoc_evocation_setup", self = true } },
}
