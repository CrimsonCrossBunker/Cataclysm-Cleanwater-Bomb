local ccb = require("ccb")

ccb.content.define_spell {
    id = "biomancer_control_mutations",
    name = ccb.content.text("Morphogenic Mastery"),
    description = ccb.content.text("The scroll said that this spell is for \"Exerting deliberate control over morphogenic alterations\", which sounds ominous."),
    valid_targets = { "self" },
    spell_class = "BIOMANCER",
    flags = { "ENHANCEMENT_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    effect = "attack",
    effect_data = "effect_biomancer_control_mutations",
    shape = "blast",
    difficulty = 12,
    max_level = 15,
    magic_type = "magiclysm_enhancement_magic",
    min_duration = 360000,
    max_duration = 3060000,
    duration_increment = 180000,
    base_energy_cost = 1200,
    extra_spells = {
        { spell = "eoc_enhancement_setup", self = true },
        { spell = "biomantic_pain_caused_light", self = true },
    },
    base_casting_time = 6000,
}
