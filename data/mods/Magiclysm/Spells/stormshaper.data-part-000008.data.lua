local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "stormshaper_cloak_fog_random",
    name = ccb.content.text_without_extraction("Cloak of Fog Random"),
    description = ccb.content.text_without_extraction("The spell that puts the effect of Cloak of Fog on you.  It's a bug if you can see it."),
    flags = { "ENHANCEMENT_SPELL", "RANDOM_TARGET", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground" },
    message = "",
    effect = "attack",
    effect_data = "effect_cloak_of_fog",
    shape = "blast",
    min_range = 5,
    max_range = 25,
    range_increment = 1,
    min_aoe = 4,
    max_aoe = 20,
    aoe_increment = 0.65,
    field = "fd_obscuring_fog",
    min_field_intensity = 2,
    max_field_intensity = 3,
    field_chance = 2,
}

ccb.content.define_spell {
    id = "stormshaper_heart_of_hurricane",
    name = ccb.content.text("Heart of the Hurricane"),
    description = ccb.content.text("Compress the fury of hurricane winds into a thin shell of raging air around yourself.  This will make it harder for you to lose your footing or be knocked down and occasionally throw attackers away from you, but the whirling winds are loud."),
    valid_targets = { "self" },
    flags = { "ENHANCEMENT_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC", "NO_EXPLOSION_SFX" },
    extra_spells = { { spell = "eoc_enhancement_setup", self = true } },
    effect = "attack",
    effect_data = "effect_heart_of_hurricane",
    shape = "blast",
    spell_class = "STORMSHAPER",
    difficulty = 7,
    max_level = 20,
    min_duration = 15000,
    max_duration = 90000,
    duration_increment = 3750,
    magic_type = "magiclysm_enhancement_magic",
    base_energy_cost = 400,
    base_casting_time = 1500,
}
