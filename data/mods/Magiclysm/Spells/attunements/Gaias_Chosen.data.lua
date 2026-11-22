local ccb = require("ccb")

ccb.content.define_spell {
    id = "terra_armor",
    name = ccb.content.text("Terra Armor"),
    description = ccb.content.text("Cover yourself in dense, invisible energy of Earth.  Higher level increase your defense abilities."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "effect_terra_armor",
    extra_spells = { { spell = "eoc_enhancement_setup", self = true } },
    shape = "blast",
    base_casting_time = 550,
    base_energy_cost = 750,
    min_duration = 50000,
    max_duration = 1800000,
    duration_increment = 50000,
    difficulty = 7,
    max_level = 35,
    flags = { "ENHANCEMENT_SPELL", "SOMATIC" },
    spell_class = "GAIAS_CHOSEN",
    magic_type = "magiclysm_enhancement_magic",
}

ccb.content.define_spell {
    id = "dust_reborn",
    shape = "blast",
    spell_class = "GAIAS_CHOSEN",
    magic_type = "magiclysm_channeling_magic",
    name = "Dust Reborn",
    description = "Create a cast of your own body and soul, hidden inside the earth's lines.  When the times come and your body is close to destruction, you can abandon it, transferring your consciousness into the cast.  But it brings with it a great price, and for your immortality, you pay with temporary bodily weakness.",
    flags = { "CHANNELING_SPELL", "SOMATIC", "VERBAL", "CONCENTRATE", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "self" },
    base_energy_cost = 1000,
    difficulty = 0,
    max_level = 0,
    base_casting_time = 2160000,
    impact_handler = "w16b_sp_imp_magiclysm_1770b81c5ed4",
    extra_spells = {
        { spell = "eoc_channeling_setup", self = true },
    },
}
