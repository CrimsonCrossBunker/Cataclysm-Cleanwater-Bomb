local ccb = require("ccb")

ccb.content.define_spell {
    id = "catoblepas_gaze_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("catoblepas gaze"),
    description = ccb.content.text_without_extraction("Does a big thwack of damage if the target can see the catoblepas"),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 15,
    max_range = 15,
    max_level = 20,
    impact_handler = "w16b_sp_imp_magiclysm_df42cb6e6d49",
}

ccb.content.define_spell {
    id = "feral_dabble_spell_selector_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("Dabbler Spell selector"),
    description = ccb.content.text_without_extraction("Random chance for a feral to have a single spell.  This picks a random spell."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "HIDDEN_SPELL" },
    valid_targets = { "hostile" },
    min_range = 60,
    max_range = 60,
    max_level = 1,
    impact_handler = "w16b_sp_imp_magiclysm_256d41a1eb72",
}
