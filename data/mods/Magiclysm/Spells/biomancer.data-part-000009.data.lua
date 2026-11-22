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

ccb.content.define_spell {
    id = "biomancer_get_more_blood",
    components = "spell_components_biomancer_get_more_blood",
    shape = "blast",
    spell_class = "BIOMANCER",
    magic_type = "magiclysm_restoration_magic",
    name = "Carmine Infusion",
    description = "Using water as a catalyst, restore some of your lost blood.  This spell has no effect if you're healthy and uninjured.",
    flags = { "RESTORATION_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    valid_targets = { "self" },
    base_energy_cost = 350,
    difficulty = 5,
    max_level = 15,
    base_casting_time = 1500,
    impact_handler = "w16b_sp_imp_magiclysm_2c3e2ed6d8d4",
    extra_spells = {
        { spell = "eoc_restoration_setup", self = true },
        { spell = "biomantic_pain_caused_light", self = true },
    },
}
