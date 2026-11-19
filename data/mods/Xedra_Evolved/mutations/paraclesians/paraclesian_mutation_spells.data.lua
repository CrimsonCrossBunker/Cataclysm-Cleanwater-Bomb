local ccb = require("ccb")

ccb.content.define_spell {
    id = "homullus_spell_wish_to_converse",
    name = ccb.content.text("Wish to Converse"),
    description = ccb.content.text("When this spell is cast, the target will somehow begin to care about you very much and can't not help but talk to."),
    valid_targets = { "hostile" },
    max_level = 1,
    flags = { "SILENT", "NO_HANDS", "NO_LEGS" },
    base_casting_time = 75,
    min_range = 15,
    max_range = 15,
    shape = "blast",
    effect = "attack",
    effect_data = "effect_wants_to_talk",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "paraclesian_translocate",
    name = ccb.content.text_without_extraction("Paraclesian Translocation"),
    description = ccb.content.text_without_extraction("The actual spell that transports you when Paraclesians use translocation spells.  It's a bug if you have it."),
    teachable = false,
    valid_targets = { "self" },
    flags = { "VERBAL", "SOMATIC" },
    effect = "translocate",
    shape = "blast",
}
