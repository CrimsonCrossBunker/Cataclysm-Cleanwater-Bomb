local ccb = require("ccb")

ccb.content.define_spell {
    id = "stormshaper_loud_voice_spell",
    name = ccb.content.text("Thundering Voice"),
    description = ccb.content.text("Increase the volume of the caster's voice, allowing every word to resound like a peal of thunder.  As a useful side effect, it makes the caster immune to hearing damage caused by loud noises."),
    valid_targets = { "self" },
    spell_class = "STORMSHAPER",
    flags = { "ENHANCEMENT_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC", "NO_LEGS" },
    extra_spells = { { spell = "eoc_enhancement_setup", self = true } },
    effect = "attack",
    effect_data = "effect_stormshaper_loud_voice",
    shape = "blast",
    difficulty = 3,
    max_level = 20,
    min_duration = 42000,
    max_duration = 882000,
    duration_increment = 42000,
    magic_type = "magiclysm_enhancement_magic",
    base_energy_cost = 150,
    base_casting_time = 250,
}
