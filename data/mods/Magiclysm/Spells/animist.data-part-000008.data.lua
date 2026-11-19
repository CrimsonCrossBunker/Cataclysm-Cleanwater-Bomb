local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "animist_radiation_bolt",
    name = ccb.content.text_without_extraction("Magic Fissile Radiation"),
    description = ccb.content.text_without_extraction("Spawns a radiation field near the target.  It's a bug if you have it directly."),
    flags = { "EVOCATION_SPELL", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    effect = "emit",
    effect_data = "emit_rad_leak",
    shape = "blast",
}

ccb.content.define_spell {
    id = "animist_cast_spells_when_silent",
    name = ccb.content.text("The Inner Voice"),
    description = ccb.content.text("Channel magic through your soul instead of your voice, allowing you to cast spells that require speech even when mute."),
    valid_targets = { "self" },
    flags = { "ENHANCEMENT_SPELL", "CONCENTRATE", "SOMATIC", "NO_LEGS" },
    max_level = 10,
    spell_class = "ANIMIST",
    effect = "attack",
    effect_data = "effect_animist_vocalize",
    extra_spells = { { spell = "eoc_enhancement_setup", self = true } },
    shape = "blast",
    difficulty = 4,
    min_duration = 30000,
    max_duration = 300000,
    duration_increment = 30000,
    magic_type = "magiclysm_enhancement_magic",
    base_casting_time = 250,
    base_energy_cost = 250,
}
