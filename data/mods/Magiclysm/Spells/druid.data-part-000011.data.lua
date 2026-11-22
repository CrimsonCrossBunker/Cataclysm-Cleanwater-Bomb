local ccb = require("ccb")

ccb.content.define_spell {
    id = "druid_traverse_the_wilds",
    shape = "blast",
    effect = "attack",
    effect_data = "effect_druid_traverse_the_wilds",
    spell_class = "DRUID",
    magic_type = "magiclysm_enhancement_magic",
    name = "Traverse the Wilds",
    description = "Blend in the wilds and urge them to speed your passage.  Trees bend out of the way, bushes do not hinder you, and even grass subtly moves your feet along.  The spell cannot be cast near civilization and similarly will fade if your travels take you out of the wilds.",
    caster_condition_fail_message = "You must be surrounded by the wilds to traverse them.",
    flags = { "ENHANCEMENT_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    valid_targets = { "self" },
    min_duration = 90000,
    duration_increment = 90000,
    max_duration = 1440000,
    base_energy_cost = 150,
    difficulty = 3,
    max_level = 15,
    base_casting_time = 250,
    caster_when = "wave14a_magiclysm_cond_1",
    extra_spells = {
        { spell = "eoc_enhancement_setup", self = true },
    },
}
