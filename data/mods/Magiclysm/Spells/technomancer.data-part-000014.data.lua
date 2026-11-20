local ccb = require("ccb")

ccb.content.define_spell {
    id = "technomancer_gain_electronics_computer_spell",
    name = ccb.content.text("Machine Mind"),
    description = ccb.content.text("This spell grants the caster an intuitive understanding of electronics and computers, making their use, repair, and construction much easier."),
    valid_targets = { "self" },
    spell_class = "TECHNOMANCER",
    flags = { "ENHANCEMENT_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC", "NO_LEGS" },
    extra_spells = { { spell = "eoc_enhancement_setup", self = true } },
    effect = "attack",
    effect_data = "effect_technomancer_gain_electronics_computer",
    components = "spell_components_technomancer_gain_electronics_computer",
    shape = "blast",
    difficulty = 1,
    max_level = 15,
    min_duration = 90000,
    max_duration = 1440000,
    duration_increment = 90000,
    magic_type = "magiclysm_enhancement_magic",
    base_energy_cost = 350,
    base_casting_time = 3000,
}
