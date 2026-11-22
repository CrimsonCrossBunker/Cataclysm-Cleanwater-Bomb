local ccb = require("ccb")

ccb.content.define_spell {
    id = "soul_afterburner_real",
    shape = "blast",
    effect = "mod_moves",
    spell_class = "SOULFIRE",
    name = "Soul Afterburner",
    description = ccb.content.text_without_extraction("This is a description for a spell the player will never see."),
    flags = { "ENHANCEMENT_SPELL", "VERBAL", "SILENT", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "self" },
    min_damage = { handler = "wave14a_magiclysm_stat_18", fallback = 0 },
    max_damage = { handler = "wave14a_magiclysm_stat_18", fallback = 0 },
    difficulty = 6,
    max_level = 35,
    extra_spells = {
        { spell = "soul_afterburner_effect_1", self = true },
        { spell = "eoc_enhancement_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "soul_afterburner_effect_1",
    shape = "blast",
    effect = "attack",
    effect_data = "soul_burn",
    name = ccb.content.text_without_extraction("Soul Burn"),
    description = ccb.content.text_without_extraction("This is a description for a spell the player will never see."),
    flags = { "ENHANCEMENT_SPELL" },
    valid_targets = { "self" },
    min_damage = 0,
    max_damage = 0,
    min_duration = { handler = "wave14a_magiclysm_stat_19", fallback = 0 },
    max_duration = { handler = "wave14a_magiclysm_stat_19", fallback = 0 },
    max_level = 35,
}
