local ccb = require("ccb")

ccb.content.define_spell {
    id = "sunmage_pocket_sun",
    name = ccb.content.text("Pocket Sun"),
    description = ccb.content.text("You create a stable portal in the fabric of reality to the sun, through which you can draw on its light and temperature."),
    valid_targets = { "self" },
    flags = { "CONJURATION_SPELL", "NO_LEGS", "CONCENTRATE", "VERBAL", "NO_PROJECTILE" },
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "pocket_sun",
    shape = "blast",
    magic_type = "magiclysm_conjuration_magic",
    spell_class = "SUN_MAGE",
    difficulty = 6,
    max_level = 40,
    base_casting_time = 150,
    base_energy_cost = 300,
    min_duration = 1000000,
    max_duration = 50000000,
    duration_increment = 1250000,
}
