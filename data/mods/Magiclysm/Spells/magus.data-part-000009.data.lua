local ccb = require("ccb")

ccb.content.define_spell {
    id = "magus_stop_attack_shield",
    name = ccb.content.text("Mageshield"),
    description = ccb.content.text("A simple but powerful spell, Mageshield will render the caster immune to any single attack.  It is indiscriminate: whether hit by an anti-tank missile or the caster stubbing their toe, it will absorb all energy of the attack and then fade."),
    valid_targets = { "self" },
    spell_class = "MAGUS",
    flags = { "CONJURATION_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    effect = "attack",
    effect_data = "effect_magus_mageshield",
    shape = "blast",
    difficulty = 2,
    max_level = 20,
    min_duration = 180000,
    max_duration = 1380000,
    duration_increment = 60000,
    magic_type = "magiclysm_conjuration_magic",
    base_energy_cost = 200,
    base_casting_time = 1500,
}
